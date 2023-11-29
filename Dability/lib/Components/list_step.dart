class ListStep {
  int numStep;
  String image;
  String description;

  ListStep(this.numStep, this.image, this.description);

  Map<String, dynamic> toJson() {
    return {
      'numPaso': numStep,
      'imagen': image,
      'descripcion': description,
    };
  }
}
