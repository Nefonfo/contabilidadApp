class Responsive {

  double fullWidthSize;
  double fullHeightSize;
  double blockSizeHorizontal;
  double blockSizeVertical;
  Responsive(double fullHeightSize, double fullWidthSize){ 
    this.fullWidthSize = fullWidthSize;
    this.fullHeightSize = fullHeightSize;
    this.blockSizeHorizontal =  fullWidthSize / 100;
    this.blockSizeVertical = fullHeightSize / 100;
  }

  double reducerBar() {
    return (this.blockSizeVertical * 86) / 100;
  }
}