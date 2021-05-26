part of 'purchase_bloc.dart';

@immutable
abstract class PurchaseState {}

class PurchaseInitial extends PurchaseState {}

class PurchaseSucessful extends PurchaseState {}

class PurchaseFail extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}
