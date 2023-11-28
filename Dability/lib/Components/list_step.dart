class ListStep {
  int numStep;
  String image;
  String description;
<<<<<<< HEAD

  ListStep(this.numStep, this.image, this.description);

  Map<String, dynamic> toJson() {
    return {
      'numPaso': numStep,
      'imagen': image,
      'descripcion': description,
    };
  }
}
=======
  String video;

  ListStep(this.numStep, this.image, this.description, this.video);
}
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
