let s1 = {name:"Pranjal Prateek"};
let s2 = new Object();
s2.college = "NIET";
function Student(branch){
this.branch = branch;
}
let s3 = new Student("ITC");
console.log(s1, s2, s3);
