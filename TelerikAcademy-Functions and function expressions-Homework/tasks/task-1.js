/* Task Description */
/* 
	Write a function that sums an array of numbers:
		numbers must be always of type Number
		returns `null` if the array is empty
		throws Error if the parameter is not passed (undefined)
		throws if any of the elements is not convertible to Number	

*/

function sum(arr) {

	var sumOfNumbers = 0,
		i,
		len;

	if(!arr.length) {
		return null;
	}
	else if(!arr.every(function (item) {
			return item == Number(item);
		})) {
		throw 'Error! All elements should be convertible to numbers'
	}

	for (i = 0, len = arr.length; i < len; i+=1) {
		sumOfNumbers += +arr[i];
	}

	return sumOfNumbers;
}

module.exports = sum;