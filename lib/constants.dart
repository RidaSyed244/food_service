// bool isEmailValid(String email) {
//   // check if email is null or empty
//   if (email == null || email.isEmpty) {
//     return false;
//   }

//   // split email into local and domain parts
//   List<String> parts = email.split('@');
//   if (parts.length != 2) {
//     return false;
//   }

//   // check local part
//   String localPart = parts[0];
//   if (localPart.isEmpty) {
//     return false;
//   }

//   // check domain part
//   String domainPart = parts[1];
//   List<String> domainParts = domainPart.split('.');
//   if (domainParts.length < 2) {
//     return false;
//   }
//   for (String part in domainParts) {
//     if (part.isEmpty) {
//       return false;
//     }
//   }

//   return true;
// }