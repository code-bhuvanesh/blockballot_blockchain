from django.forms import ModelForm
from .models import StudentModel

class StudentForm(ModelForm):
    class Meta:
        model = StudentModel
        # fields = '__all__'
        fields = ["name", "regno"]