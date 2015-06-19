/* Task Description */
/* 
	*	Create a module for working with books
		*	The module must provide the following functionalities:
			*	Add a new book to category
				*	Each book has unique title, author and ISBN
				*	It must return the newly created book with assigned ID
				*	If the category is missing, it must be automatically created
			*	List all books
				*	Books are sorted by ID
				*	This can be done by author, by category or all
			*	List all categories
				*	Categories are sorted by ID
		*	Each book/catagory has a unique identifier (ID) that is a number greater than or equal to 1
			*	When adding a book/category, the ID is generated automatically
		*	Add validation everywhere, where possible
			*	Book title and category name must be between 2 and 100 characters, including letters, digits and special characters ('!', ',', '.', etc)
			*	Author is any non-empty string
			*	Unique params are Book title and Book ISBN
			*	Book ISBN is an unique code that contains either 10 or 13 digits
			*	If something is not valid - throw Error
*/
function solve() {
	var library = (function () {
		var books = [],
			categories = [];

		function orderByID(a, b) {
			return a.ID - b.ID;
		}

		function listBooks() {
			function filterBooksByOption(book) {
				if (option['category'] && book['category'] === option['category'] ||
					option['author'] && books['author'] === option['author'] ||
					option['all']) {
					return true;
				} else {
					return false;
				}
			}

			var option = arguments[0];

			if (arguments.length === 0) {
				return books.slice().sort(orderByID);
			} else {
				return books.filter(filterBooksByOption).sort(orderByID);
			}
		}

		function isCreated(name, type) {
			for (var i = 0; i < books.length; i+=1) {
				if(books[i][type] == name) {
					return true;
				}
			}

			return false;
		}

		function validateISBN(isbn) {
			if(isbn.length !== 10 && isbn.length !== 13) {
				throw 'ISBN must be 10 or 13 symbols';
			}
		}

		function validateAuthor(author) {
			if(author == '') {
				throw 'Author must be a non empty string';
			}
		}

		function addBook(book) {
			book.ID = books.length + 1;

			validateISBN(book.isbn);
			validateAuthor(book.author);
			if(isCreated(book.title, 'title')) {
				throw 'Book title already exists';
			}
			if(isCreated(book.isbn, 'isbn')) {
				throw 'Book isbn already exists';
			}

			(function addCategory(book) {
				function containsCategory(category) {
					if (category.name === categoryName) {
						return true;
					} else {
						return false;
					}
				}

				var categoryName = book.category,
					category;

				if (categories.some(containsCategory) === false) {
					category = {
						name: categoryName,
						ID: categories.length + 1
					}

					categories.push(category);
				}
			} (book));

			books.push(book);
			return book;
		}

		function listCategories() {
			function mapCategories(category) {
				return category.name;
			}
			return categories.slice().sort(orderByID).map(mapCategories);
		}

		return {
			books: {
				list: listBooks,
				add: addBook
			},
			categories: {
				list: listCategories
			}
		};
	} ());

	return library;
}

//solve();

module.exports = solve;
