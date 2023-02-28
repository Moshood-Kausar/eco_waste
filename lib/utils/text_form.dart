
import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator, onChanged;
  final Widget? icon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? secure;
  final IconData? suffixIcon;
  final String? hintText, text, initialValue;

  const AppTextFormField(
      {Key? key,
      required this.controller,
      required this.text,
      required this.validator,
      this.icon,
      this.keyboardType,
      this.secure,
      this.hintText,
      this.suffixIcon,
      this.onChanged,
      this.textInputAction,
      
      this.textCapitalization, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            '$text',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Color(0xff525252),
            ),
          ),
        ),
        TextFormField(
          cursorColor: const Color(0xff525252),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp("[a-zA-Z0-9 space _ / . @]")),
          ],
          validator: validator,
          initialValue: initialValue,
          onChanged: onChanged,
          obscureText: secure ?? false,
          // obscuringCharacter: '◉',
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            fillColor: const Color(0xffF4F4F4),
            filled: true,
            isDense: true,
            suffixIcon: icon ?? Icon(suffixIcon, color: Colors.grey),
            contentPadding:
                const EdgeInsets.only(left: 10.0, right: 0.0, top: 12),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary)),
          ),
        ),
      ],
    );
  }
}

// class ResourcesCard extends StatelessWidget {
//   final String img, title;
//   final void Function()? onTap;
//   const ResourcesCard({
//     Key? key,
//     required this.img,
//     required this.onTap,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(14.0),
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color(0xffE0E0E0), width: 0.5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 120,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   border: Border.all(
//                     color: const Color(0xffE0E0E0),
//                     width: 0.3,
//                   ),
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12)),
//                   image: DecorationImage(
//                       image: AssetImage(
//                         img,
//                       ),
//                       fit: BoxFit.cover)),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w900,
//                             color: Color(0xff161616)),
//                       ),
//                       MaterialButton(
//                         onPressed: onTap,
//                         color: const Color(0xffEDF5FF),
//                         textColor: const Color(0xff0F62FE),
//                         child: Row(
//                           children: const [
//                             Text('View'),
//                             Icon(
//                               Icons.remove_red_eye,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
