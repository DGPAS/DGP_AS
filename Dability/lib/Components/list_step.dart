class ListStep {
  int numStep;
  String image;
  String description;

  ListStep(this.numStep, this.image, this.description);

  Map<String, dynamic> toJson() {
    return {
      'numStep': numStep,
      'image': image,
      'description': description,
    };
  }
}
