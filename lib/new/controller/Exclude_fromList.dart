class TrashCan
{
  
  static var lista = [''];

  static void updateList(listaArgument)
  {
    if(listaArgument is List)
    {
    lista.clear();
    lista.addAll(listaArgument.map((item) => item.toString()).toList());
    }
  }

  static get listValue
  {
    return lista;
  }

  static List<String> excluirElemento(String stringToExclude)
  {
    int index = lista.indexOf(stringToExclude);
    lista.removeAt(index);
    return lista;
  }

}