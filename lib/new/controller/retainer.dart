
import 'package:shared_preferences/shared_preferences.dart';

  Future<void> SaveEisenLists(List<String> eiseinList, String key) async
  {
    final dataSave = await SharedPreferences.getInstance();
    await dataSave.setStringList(key, eiseinList);

  }

  Future<List<String>?> getEisenLists(String key) async{
    final retainData = await SharedPreferences.getInstance();
    return retainData.getStringList(key);
  }

  Future<void> SaveStateList(List<int> states, String key) async
  {
    final dataSave = await SharedPreferences.getInstance();
    await dataSave.setStringList(key, 
    states.map((element)=>element.toString()).toList()
    );
  }

  Future<void> SaveStateActivitiesList(List<String> activities, String key) async
  {
    final dataSave = await SharedPreferences.getInstance();
    await dataSave.setStringList(key, activities);
  }

  Future<List<String>?> GetStateActivitiesList(String key) async
  {
    final RetainData = await SharedPreferences.getInstance();
    return RetainData.getStringList(key);
 } 

  Future<List<int>> GetStateList(String key) async
  {
    final RetainData = await SharedPreferences.getInstance();
    
    return (RetainData.getStringList(key)?.map((element)=>int.parse(element)))!.toList();
  } 

  Future<bool> validateFirsTime(bool isFirstTime, String key) async
  {
    final RetainData = await SharedPreferences.getInstance();

    return RetainData.setBool(key, isFirstTime);
  }

  Future<bool?> ValidatedFirstTime(String key) async
  {
    final RecoverData = await SharedPreferences.getInstance();

    return RecoverData.getBool(key);
  }

  Future<void> SavePomodoroTime(int duration, String key) async
  {
    final dataToSave = await SharedPreferences.getInstance();
    dataToSave.setInt(key, duration);
  }

  Future<int> GetPomodoroTime(String key) async
  {
    final dataRetrieve = await SharedPreferences.getInstance();
    return dataRetrieve.getInt(key) ?? 1800;
  }