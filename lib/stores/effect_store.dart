import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as imageLib;
import 'package:instaclone/models/filter.dart';
import 'package:mobx/mobx.dart';

part 'effect_store.g.dart';

class EffectStore = _EffectStore with _$EffectStore;

abstract class _EffectStore with Store {
//  _EffectStore(){
//    autorun((_){
//      applyEffect(sourceImage);
//    });
//  }

// ADICIONA O OBSERVACLE DO BYTES
//CRIA A FUNÇÃO DE EFEITO
// APLICA O EFEITO DENTRO DA FUNÇÃO COM A FUNÇÃO DE APLICAR EFFEITO
// INICIA A FUNÇÃO NA FUNÇÃO INIT IMAGE
// CRIA O BNOTÃO DO EFEITO
  @observable
  imageLib.Image sourceImage;

  @observable
  List<int> bytes;

  @observable
  List<int> effectBytes;

  @observable
  String effectName;

  @observable
  bool isVisible = true;

  @observable
  int blacks;

  @observable
  int red = 0;

  @observable
  int green = 0;

  @observable
  int blue = 0;

  @observable
  int alpha = 1;

  @observable
  int whites;

  @observable
  int mids;

  @observable
  num contrast = 0;

  @observable
  num saturation;

  @observable
  num brightness = 0;

  @observable
  num gamma;

  @observable
  num exposure;

  @observable
  num hue;

  @observable
  num amount;

  @observable
  int count = 0;

  @action
  setEffectName(value) => effectName = value;

  @action
  setEffect(value) => bytes = value;

  @action
  setVisibility() {
    isVisible = true;
  }

  ObservableList<Filter> filterList = ObservableList<Filter>();

  @action
  Future<void> initImage(imageLib.Image image) async {
    //criar json de efeitos
    //EFEITOS
    ////Normal
    bytes = await applyEffect(image);
    filterList.add(Filter("Normal", bytes, false));
    var greyscaleImage = imageLib.grayscale(image.clone());

    ////São José
    effectBytes = await applyEffect(image,
        red: 0, green: 10, blue: 20, alpha: 0, contrast: 15, brightness: 18);
    filterList.add(Filter("São José", effectBytes, false));

    ////Málaga
    effectBytes = await applyEffect(image,
        red: 10, green: 6, blue: 6, alpha: 0, contrast: 18, brightness: 18);
    filterList.add(Filter("Málaga", effectBytes, false));

    ////São Paulo
    effectBytes = await applyEffect(greyscaleImage,
        red: 0, green: 0, blue: 0, alpha: 0, contrast: 35, brightness: 30);
    filterList.add(Filter("São Paulo", effectBytes, false));

    ////Atlanta
    effectBytes = await applyEffect(image,
        red: 2, green: 8, blue: 16, alpha: 0, contrast: 18, brightness: 22);
    filterList.add(Filter("Atlanta", effectBytes, false));

    ////Santiago
    effectBytes = await applyEffect(image,
        red: 0, green: 5, blue: 50, alpha: 0, contrast: 16, brightness: 20);
    filterList.add(Filter("Santiago", effectBytes, false));

    ////Minneapolis
    effectBytes = await applyEffect(image,
        red: 10, green: 20, blue: 20, alpha: 0, contrast: 20, brightness: 12);
    filterList.add(Filter("Minneapolis", effectBytes, false));

    ////Harbin
    effectBytes = await applyEffect(image,
        red: 16, green: 16, blue: 16, alpha: 0, contrast: 35, brightness: 35);
    filterList.add(Filter("Harbin", effectBytes, false));

    ////Cali
    effectBytes = await applyEffect(image,
        red: 0, green: 0, blue: 33, alpha: 0, contrast: 38, brightness: 35);
    filterList.add(Filter("Mendoza", effectBytes, false));

    ////Salvador
    effectBytes = await applyEffect(image,
        red: 20, green: 8, blue: 0, alpha: 0, contrast: 18, brightness: 18);
    filterList.add(Filter("Salvador", effectBytes, false));

    ////Harare
    effectBytes = await applyEffect(image,
        red: 6, green: 6, blue: 6, alpha: 0, contrast: 45, brightness: 5);
    filterList.add(Filter("Harare", effectBytes, false));

    ////Kingston
    effectBytes = await applyEffect(image,
        red: 0, green: 22, blue: 4, alpha: 0, contrast: 36, brightness: 18);
    filterList.add(Filter("Kingston", effectBytes, false));

    ////Cordoba
    effectBytes = await applyEffect(image,
        red: 12, green: 6, blue: 6, alpha: 0, contrast: 35, brightness: 15);
    filterList.add(Filter("Córdoba", effectBytes, false));

    ////Nha Tang
    effectBytes = await applyEffect(image,
        red: 12, green: 6, blue: 12, alpha: 0, contrast: 28, brightness: 19);
    filterList.add(Filter("Nha Tang", effectBytes, false));

    ////Mendoza
    effectBytes = await applyEffect(image,
        red: 0, green: 12, blue: 23, alpha: 0, contrast: 8, brightness: 35);
    filterList.add(Filter("Mendoza", effectBytes, false));

    ////Porto Alegre
    effectBytes = await applyEffect(image,
        red: 0, green: 0, blue: 45, alpha: 0, contrast: 35, brightness: 18);
    filterList.add(Filter("Porto Alegre", effectBytes, false));

    ////Orleans
    effectBytes = await applyEffect(greyscaleImage,
        red: 0, green: 0, blue: 10, alpha: 0, contrast: 25, brightness: 18);
    filterList.add(Filter("Orleans", effectBytes, false));
    bytes = await applyEffect(image);

    ////Copenhagen
    effectBytes = await applyEffect(image,
        red: 16, green: 9, blue: 0, alpha: 0, contrast: 25, brightness: 18);
    filterList.add(Filter("Copenhagen", effectBytes, false));
    bytes = await applyEffect(image);
  }

  Future<List<int>> applyEffect(imageLib.Image image,
      {int red,
      int green,
      int blue,
      int alpha,
      int contrast,
      int brightness}) async {
    bytes = imageLib.encodeNamedImage(image, "new.jpg");
    sourceImage = image.clone();
    sourceImage = imageLib.colorOffset(sourceImage,
        red: red != null ? red : 0,
        green: green != null ? green : 0,
        blue: blue != null ? blue : 0,
        alpha: alpha != null ? alpha : 0);
    sourceImage =
        imageLib.contrast(sourceImage, contrast != null ? contrast + 100 : 100);
    sourceImage =
        imageLib.brightness(sourceImage, brightness != null ? brightness : 0);
    bytes = imageLib.encodeJpg(sourceImage, quality: 75);
    bytes = imageLib.encodeNamedImage(sourceImage, "${Timestamp.now()}.jpg");
    return bytes;
  }
}
