
class ResultLogic {

  bool isVisible = false;


  String resultMessage(int userResults, int numOfQs) {
    if (userResults > ((numOfQs * 7) * 0.1)) {
      isVisible = false;
      print(isVisible);
      return 'Great results! You can move to the next Lesson';
    } else if (userResults >= numOfQs / 2) {
      return 'Well Done! You may want to review the content later';
    } else {
      isVisible = true;
      print(isVisible);
      return 'Try again!';
    }
  }

  bool failMessage(int userResults, int numOfQs) {
    if (userResults >= numOfQs / 2) {
      return isVisible = false;
    } else {
      return isVisible = true;
    }
  }
}