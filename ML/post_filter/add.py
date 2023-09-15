
import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["sih"]
mycol = mydb["posts"]


mydict = [{
    "userId":"5646464",
    "heading" :"Insurance company refused to pay my medical claim",
    "tags":["medical insurance","fraudery"],
    "desc":"I was admitted for 5 days and was charged 70000 for my kidney stone surgery, the insurance company refused to pay the claim by defining my claim as a voluntary"
},
{
    "userId":"56545482",
    "heading" :"College administration forced me to pay tuition fees of remaining academic years for taking an academic drop from university",
    "tags":["education","universities","student"],
    "desc":"The College says that the students who take an academic drop are supposed to pay the tuition fees of the upcoming semesters which is violation of rights"
},
{
    "userId":"5645544",
    "heading" :"Refused admission to university",
    "tags":["student","engineering","education"],
    "desc":"I reached the Admission councel after 4 days the process ended for which I submitted reason to the adminstration. It seems like the seats were sold under management quota at high prices. This directly violates my right to education and I need strict legal action"
},
{
    "userId":"564643434",
    "heading" :"Hospital refused to provide medical aid",
    "tags":["medical"],
    "desc":"Found someone having an accident on the road, the patient was bleeding and SigmaMale Hospitals in Memepur,Instagram refused to accept patient knowing the situtation of the patient"
},
{
    "userId":"564454546464",
    "heading" :"Lawyers are adverizing themselves in Websites ",
    "tags":["constitution","technology","advertisement","law"],
    "desc":"As per the constitution act 1960, lawyers are prohibited to advertise their work by any means. Some applications creates ads pretending to be social media posts."
},
{
    "userId":"56463434",
    "heading" :"I recieved a notice from ITO, stating that I have commited malpractice for saving my taxes",
    "tags":["accountancy","income taxes","ITO"],
    "desc":"I have been fined 100000 with interests by the Income tax department for minimizing my taxes, for which I need a lawyer urgently"
}





]
for element in mydict:
    x = mycol.insert_one(element)