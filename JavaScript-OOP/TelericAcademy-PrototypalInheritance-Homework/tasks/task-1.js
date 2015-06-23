/* Task Description */
/*
 * Create an object domElement, that has the following properties and methods:
 * use prototypal inheritance, without function constructors
 * method init() that gets the domElement type
 * i.e. `Object.create(domElement).init('div')`
 * property type that is the type of the domElement
 * a valid type is any non-empty string that contains only Latin letters and digits
 * property innerHTML of type string
 * gets the domElement, parsed as valid HTML
 * <type attr1="value1" attr2="value2" ...> .. content / children's.innerHTML .. </type>
 * property content of type string
 * sets the content of the element
 * works only if there are no children
 * property attributes
 * each attribute has name and value
 * a valid attribute has a non-empty string for a name that contains only Latin letters and digits or dashes (-)
 * property children
 * each child is a domElement or a string
 * property parent
 * parent is a domElement
 * method appendChild(domElement / string)
 * appends to the end of children list
 * method addAttribute(name, value)
 * throw Error if type is not valid
 * // method removeAttribute(attribute)
 */


/* Example
 var meta = Object.create(domElement)
 .init('meta')
 .addAttribute('charset', 'utf-8');
 var head = Object.create(domElement)
 .init('head')
 .appendChild(meta)
 var div = Object.create(domElement)
 .init('div')
 .addAttribute('style', 'font-size: 42px');
 div.content = 'Hello, world!';
 var body = Object.create(domElement)
 .init('body')
 .appendChild(div)
 .addAttribute('id', 'cuki')
 .addAttribute('bgcolor', '#012345');
 var root = Object.create(domElement)
 .init('html')
 .appendChild(head)
 .appendChild(body);
 console.log(root.innerHTML);
 Outputs:
 <html><head><meta charset="utf-8"></meta></head><body bgcolor="#012345" id="cuki"><div style="font-size: 42px">Hello, world!</div></body></html>
 */


function solve() {
    var domElement = (function () {

        function isAlphaNumeric(s) {
            var p  = /^[A-z0-9]+$/g;
            return p.test(s);
        }

        function isAlphaNumericDashes(s) {
            var p  = /^[A-z0-9-]+$/g;
            return p.test(s);
        }

        var domElement = {
            init: function(type) {

                if(type === '' || typeof type !== 'string') {
                    throw 'Type cannot be empty';
                }

                if(!isAlphaNumeric(type)) {
                    throw 'Type cannot be empty';
                }

                this.type = type;
                this.attributes = {};
                this.children = [];
                this.content = '';

                return this;
            },
            appendChild: function(child) {

                this.children.push(child);

                return this;
            },
            addAttribute: function(name, value) {

                if(name === '') {
                    throw 'Name cannot be empty';
                }

                if(!isAlphaNumericDashes(name)) {
                    throw 'Type cannot be empty';
                }

                this.attributes[name] = value;

                return this;
            },
            get innerHTML(){
                return createInnerHtml(this);
            }
        };

        function createInnerHtml(obj) {
            var innerResult = '',
                result;
            if (obj.children.length > 0) {
                obj.children.forEach(function(item) {
                    typeof item === 'string' ? innerResult += item : innerResult += item.innerHTML;
                });
                result = '<' + obj.type + parseAttributes(obj.attributes) + '>' + innerResult + '</' + obj.type + '>';
            } else {
                result = '<' + obj.type + parseAttributes(obj.attributes) + '>' + obj.content + '</' + obj.type + '>';
            }

            return result;
        }

        function parseAttributes(obj) {
            var result = ' ',
                attr,
                arr = [];
            for (attr in obj) {
                arr.push([attr, obj[attr]]);
            }
            arr.sort();
            arr.forEach(function(item) {
                result += item[0] + '="' + item[1] + '" ';
            });
            return result.trimRight();
        }

        return domElement;
    } ());
    return domElement;
}

module.exports = solve;