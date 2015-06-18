/* Task description */
/*
	Write a function a function that finds all the prime numbers in a range
		1) it should return the prime numbers in an array
		2) it must throw an Error if any on the range params is not convertible to `string`
		3) it must throw an Error if any of the range params is missing
*/

function solve() {
	return function findPrimes(x, y) {

		if(arguments.length < 2) {
			throw 'Error! Number of arguments is not valid!'
		}

		var resultArr = [],
			i,
			j,
			downLimit = Math.min(x, y),
			upLimit = Math.max(x, y),
			isPrime = true;

		for (i = downLimit; i <= upLimit; i+=1) {
			if(i <= 1) {
				continue;
			}

			if(i == 2) {
				resultArr.push(+i);
				continue;
			}

			for (j = 2; j < i; j+=1) {
				if(i % j == 0) {
					isPrime = false;
					break;
				}
			}

			if(isPrime) {
				resultArr.push(+i);
			}else {
				isPrime = true;
			}
		}

		return resultArr;
	}
}

//function findPrimes(x, y) {
//
//	if(arguments.length < 2) {
//		throw 'Error! Number of arguments is not valid!'
//	}
//
//	var resultArr = [],
//		i,
//		j,
//		downLimit = Math.min(x, y),
//		upLimit = Math.max(x, y),
//		isPrime = true;
//
//	for (i = downLimit; i <= upLimit; i+=1) {
//		if(i <= 1) {
//			continue;
//		}
//
//		if(i == 2) {
//			resultArr.push(+i);
//			continue;
//		}
//
//		for (j = 2; j < i; j+=1) {
//			if(i % j == 0) {
//				isPrime = false;
//				break;
//			}
//		}
//
//		if(isPrime) {
//			resultArr.push(+i);
//		}else {
//			isPrime = true;
//		}
//	}
//
//	return resultArr;
//}

//module.exports = findPrimes;