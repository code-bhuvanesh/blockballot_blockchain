from django.http import JsonResponse
from django.shortcuts import render
from .models import Image
from django.http import HttpResponse
import os
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings
from backend_logic import face_features_extraction
from backend_logic.face_features_extraction import extract_features
from .forms import StudentForm
from .JsonParsing import add_student_to_json, get_details

def homePage(request):
        # if request.method == 'POST':
        #     form = ImageUploadForm(request.POST, request.FILES)
        # if form.is_valid():
        #     form.save()
        #     return redirect('index')
        # else:
        #     form = ImageUploadForm()
        # print(request)
        routes =  {
            'student_recogonizer' : 'welcome'
        }
        
        return JsonResponse(routes, safe=False)

def showImages(request):
    form = StudentForm
    context = {
        'form' : form
    }
    return render(request,"display.html", context)

def registerStudent(request):
    # if request.method == 'GET':
    data = StudentForm()
    context = {
        'form' : data
    }
    if request.method == 'POST':
        voterid = request.POST["voterid"]
 
        files = request.FILES.getlist('files')
        for image in files:
            path_to_save = f"backend_logic\\voters_image\{voterid}"
            if not (os.path.isdir(path_to_save)):
                os.mkdir(path_to_save)
            file_path = os.path.join(path_to_save, image.name)
            with open(file_path, 'wb+') as destination:
                for chunk in image.chunks():
                    destination.write(chunk)
        extract_features()
    return JsonResponse("registerd")
   
    

def get_voter(request):
    if request.method == 'POST':
        uploaded_file = request.FILES['file']
        voter_id = request.POST["voterid"]
        print("file recieved")
        # Process the uploaded file here
        path = default_storage.save('tmp/test.jpg', ContentFile(uploaded_file.read()))
        tmp_file = os.path.join(settings.MEDIA_ROOT, path)
        faceDetection = face_features_extraction.FaceFeatureExtraction()
        d_voter_id = faceDetection.detectFace(tmp_file)
        print(f"voterid is {voter_id}")

        return JsonResponse([d_voter_id==voter_id],safe=False)
    else:
        print("file not recieved")
        return JsonResponse(["file not received"])
    

