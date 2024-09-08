
class ShowingBoxControl
{
  static bool isPoped = false;

  static void Function()? onClose;
  static void Function()? onOpen;

  static void pop()
  {
    isPoped = true;
  }

  static void Unpop()
  {
    isPoped = false;
  }

  static void feltAnimation()
  {
    if (onClose != null) {
      onClose!();  // Notifica a função de callback quando a pop-up deve ser fechada
    }
  }

  static void feltOpening()
  {
    if(onOpen != null)
    {
      onOpen!();
    }
  }
}