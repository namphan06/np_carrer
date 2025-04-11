enum EnumEducationLevel {
  noFormalEducation("No Formal Education", "EDU0"),
  primarySchool("Completed Primary School", "EDU1"),
  highSchool("Graduated Secondary/High School", "EDU2"),
  preUniversity("Completed Pre-University Program", "EDU3"),
  diplomaOrCertificate("Graduated with Diploma/Certificate", "EDU4"),
  bachelorDegree("Graduated with Bachelor’s Degree", "EDU5");

  final String label;
  final String code;

  const EnumEducationLevel(this.label, this.code);
}
