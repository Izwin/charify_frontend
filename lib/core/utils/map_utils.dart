extension MapUtils on Map{
  withoutNulls(){
    removeWhere((k,v) => k == null || v == null);
    return this;
  }
}