<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    public function home() { return view('home'); }
    public function about() { return view('aboutus'); }
    public function contact() { return view('contact'); }
    public function shop() { return view('shop'); }
    public function cart() { return view('cart'); }
    public function orders() { return view('orders'); }
    public function medicineDetails($id) { return view('medicine_details', compact('id')); }
    public function checkout() { return view('checkout'); }
}
