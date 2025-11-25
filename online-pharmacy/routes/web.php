<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\PharmacistController;

// Public pages
Route::get('/', [UserController::class, 'home'])->name('home');
Route::get('/about', [UserController::class, 'about']);
Route::get('/contact', [UserController::class, 'contact']);
Route::get('/shop', [UserController::class, 'shop']);
Route::get('/cart', [UserController::class, 'cart']);
Route::get('/orders', [UserController::class, 'orders']);
Route::get('/medicine/{id}', [UserController::class, 'medicineDetails']);
Route::get('/checkout', [UserController::class, 'checkout']);

// Admin pages
Route::prefix('admin')->group(function () {
    Route::get('/dashboard', [AdminController::class, 'dashboard']);
    Route::get('/orders', [AdminController::class, 'orders']);
    Route::get('/medicines', [AdminController::class, 'medicines']);
    Route::get('/users', [AdminController::class, 'users']);
});

// Pharmacist pages
Route::prefix('pharmacist')->group(function () {
    Route::get('/pending', [PharmacistController::class, 'pendingPrescriptions']);
    Route::get('/approve', [PharmacistController::class, 'approveOrders']);
    Route::get('/inventory', [PharmacistController::class, 'inventory']);
});
