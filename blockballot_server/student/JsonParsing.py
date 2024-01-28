import json

def get_details(regno):
    with open("E:\Projects\hackathon\student_recognizer\student_recognizer_backend\\backend_logic\student.json","r" ) as json_file:
        Details = json.load (json_file)
    Student_detials = None
    try:            
        Student_detials = Details[regno]
    except:
        print("no student")
    
    return Student_detials

# value= get_details('41111105')

def read_all():
    with open("E:\Projects\hackathon\student_recognizer\student_recognizer_backend\\backend_logic\student.json","r" ) as json_file:
        Details = json.loads(json.load(json_file))

    return Details

def add_student_to_json(regno,
              name, 
              sec, 
              course, 
              dob, 
              block, 
              email, 
              mobile_num, 
              father_name, 
              mother_name, 
              parents_number, 
              co_ordinator, 
              b_point, 
              academicYear):
    Student_details = {
           regno : {
            "regno" : regno,
            "Name": name,
            "Section": sec,
            "course": course,
            "DOB": dob,
            "Block": block,
            "Email": email,
            "Mobile Number": mobile_num,
            "Father Name": father_name,
            "Mother Name": mother_name,
            "Parents Number": parents_number,
            "Co-ordinator": co_ordinator,
            "Boarding Point": b_point,
            "Acedemic Year": academicYear
    }}

    with open("E:\Projects\hackathon\student_recognizer\student_recognizer_backend\\backend_logic\student.json", "r+") as fi:
        data = json.load(fi)
        data.update(Student_details)
        fi.seek(0)
        json.dump(data, fi, indent=4)



# add_student_to_json(
#         regno="4111098", 
#         name= "bhuvanesh",
#         sec="A4",
#         course="BE CSE Regular",
#         dob="26/11/2003",
#         block="16th block",
#         email="bhuvaneshdeavaraj@gmail.com",
#         mobile_num="9278443765",
#         parents_number="7845637467",
#         father_name="devaraj",
#         mother_name="kalaivani",
#         b_point="sholinganallur",
#         academicYear="2021-2025",
#         co_ordinator="mohana prasad"
#         )


