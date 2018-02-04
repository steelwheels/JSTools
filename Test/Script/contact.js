console.log("*** Test contact ***\n") ;

const contact = require('contact') ;

switch(contact.authorize()){
  case Authorize.Undetermined:
	console.log("Undetermined\n") ;
  break ;
  case Authorize.Denied:
	console.log("Denied\n") ;
  break ;
  case Authorize.Authorized:
	console.log("Authorized\n") ;
  break ;
}

console.log("Press Any Key\n") ;
while(console.getKey() == null){
}

