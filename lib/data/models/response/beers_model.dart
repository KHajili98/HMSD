import '../../../domain/entities/beers.dart';

class BeersModel extends Beers {
  BeersModel({
    int? id,
    String? name,
    String? tagline,
    String? firstBrewed,
    String? description,
    String? imageUrl,
    dynamic abv,
    dynamic ibu,
    int? targetFg,
    dynamic targetOg,
    dynamic ebc,
    dynamic srm,
    dynamic ph,
    dynamic attenuationLevel,
    BoilVolume? volume,
    BoilVolume? boilVolume,
    Method? method,
    Ingredients? ingredients,
    List<String>? foodPairing,
    String? brewersTips,
    String? contributedBy,
  }) : super(
          id: id,
          name: name,
          tagline: tagline,
          firstBrewed: firstBrewed,
          description: description,
          imageUrl: imageUrl,
          abv: abv,
          ibu: ibu,
          targetFg: targetFg,
          targetOg: targetOg,
          ebc: ebc,
          ph: ph,
          attenuationLevel: attenuationLevel,
          volume: volume,
          boilVolume: boilVolume,
          method: method,
          ingredients: ingredients,
          foodPairing: foodPairing,
          brewersTips: brewersTips,
          contributedBy: contributedBy,
        );

  factory BeersModel.fromJson(Map<String, dynamic> json) => BeersModel(
        id: json["id"],
        name: json["name"],
        tagline: json["tagline"],
        firstBrewed: json["first_brewed"],
        description: json["description"],
        imageUrl: json["image_url"],
        abv: json["abv"],
        ibu: json["ibu"],
        targetFg: json["target_fg"],
        targetOg: json["target_og"],
        ebc: json["ebc"],
        srm: json["srm"],
        ph: json["ph"],
        attenuationLevel: json["attenuation_level"],
        volume: BoilVolumeModel.fromJson(json["volume"]),
        boilVolume: BoilVolumeModel.fromJson(json["boil_volume"]),
        method: MethodModel.fromJson(json["method"]),
        ingredients: IngredientsModel.fromJson(json["ingredients"]),
        foodPairing: List<String>.from(json["food_pairing"].map((x) => x)),
        brewersTips: json["brewers_tips"],
        contributedBy: json["contributed_by"],
      );
}

class BoilVolumeModel extends BoilVolume {
  const BoilVolumeModel({
    dynamic value,
    String? unit,
  }) : super(value: value, unit: unit);

  factory BoilVolumeModel.fromJson(Map<String, dynamic> json) => BoilVolumeModel(
        value: json["value"],
        unit: json["unit"],
      );
}

class IngredientsModel extends Ingredients {
  const IngredientsModel({
    List<MaltModel>? malt,
    List<HopModel>? hops,
    String? yeast,
  }) : super(
          malt: malt,
          hops: hops,
          yeast: yeast,
        );

  factory IngredientsModel.fromJson(Map<String, dynamic> json) => IngredientsModel(
        malt: List<MaltModel>.from(json["malt"].map((x) => MaltModel.fromJson(x))),
        hops: List<HopModel>.from(json["hops"].map((x) => HopModel.fromJson(x))),
        yeast: json["yeast"],
      );
}

class HopModel extends Hop {
  const HopModel({
    String? name,
    BoilVolumeModel? amount,
    String? add,
    String? attribute,
  }) : super(
          name: name,
          amount: amount,
          add: add,
          attribute: attribute,
        );

  factory HopModel.fromJson(Map<String, dynamic> json) => HopModel(
        name: json["name"],
        amount: BoilVolumeModel.fromJson(json["amount"]),
        add: json["add"],
        attribute: json["attribute"],
      );
}

class MaltModel extends Malt {
  const MaltModel({
    String? name,
    BoilVolumeModel? amount,
  }) : super(amount: amount, name: name);

  factory MaltModel.fromJson(Map<String, dynamic> json) => MaltModel(
        name: json["name"],
        amount: BoilVolumeModel.fromJson(json["amount"]),
      );
}

class MethodModel extends Method {
  const MethodModel({
    List<MashTempModel>? mashTemp,
    FermentationModel? fermentation,
    dynamic twist,
  }) : super(
          mashTemp: mashTemp,
          fermentation: fermentation,
          twist: twist,
        );

  factory MethodModel.fromJson(Map<String, dynamic> json) => MethodModel(
        mashTemp: List<MashTempModel>.from(json["mash_temp"].map((x) => MashTempModel.fromJson(x))),
        fermentation: FermentationModel.fromJson(json["fermentation"]),
        twist: json["twist"],
      );
}

class FermentationModel extends Fermentation {
  const FermentationModel({
    BoilVolumeModel? temp,
  }) : super(temp: temp);

  factory FermentationModel.fromJson(Map<String, dynamic> json) => FermentationModel(
        temp: BoilVolumeModel.fromJson(json["temp"]),
      );
}

class MashTempModel extends MashTemp {
  const MashTempModel({
    BoilVolumeModel? temp,
    int? duration,
  }) : super(temp: temp, duration: duration);

  factory MashTempModel.fromJson(Map<String, dynamic> json) => MashTempModel(
        temp: BoilVolumeModel.fromJson(json["temp"]),
        duration: json["duration"],
      );
}
