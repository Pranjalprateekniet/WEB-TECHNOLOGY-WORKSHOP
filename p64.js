let a = [1,2];
let b = [...a,3];
function count(...x){
return x.length;
}
console.log(b, count(1,2,3));
