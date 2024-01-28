import json
def get_details(regno):
    with open("voters.json","r" ) as json_file:
        Details = json.load (json_file)

    Student_detials = Details[regno]
    return Student_detials

# value= get_details('41111105')

def read_all():
    with open("voters.json","r" ) as json_file:
        Details = json.loads(json.load(json_file))

    return Details

def write_new(regno,
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
              ayear):
    Student_details = {
           regno : {
	           "voter_id": name,
              
    }}

    with open("visitor.json", "r+") as fi:
        data = json.load(fi)
        data.update(Student_details)
        fi.seek(0)
        json.dump(data, fi, indent=4)




