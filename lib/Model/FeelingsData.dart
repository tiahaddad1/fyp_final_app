class FeelingsData {
  late int feelingsRate;
  late int dayOfWeek;

  FeelingsData(int feelingsRate, int dayOfWeek) {
    this.feelingsRate = feelingsRate;
    this.dayOfWeek = dayOfWeek;
  }
}

//dayOfWeek attribute
//the days of the week are marked from 1-7 days, 
//this means that 1 indicates the beginning of the week: Monday
//and 7 indicates the end of the week: Sunday

//feelingsRate attribute
//the feelings rate number is derived from the feelings provided
//it ranges between 1-6:
//1: Excited, 2: Happy, 3:Confused, 4:Sad, 5:Scared, 6:Angry