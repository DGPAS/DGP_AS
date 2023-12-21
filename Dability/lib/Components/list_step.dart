class ListStep {
  int numStep;
  String selectedImage;
  String description;

  ListStep(this.numStep, this.selectedImage, this.description);

  Map<String, dynamic> toJson() {
    return {
      'numStep': numStep,
      'image': selectedImage,
      'description': description,
    };
  }
}
