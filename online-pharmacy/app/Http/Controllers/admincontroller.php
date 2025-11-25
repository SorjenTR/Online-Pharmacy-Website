<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function dashboard() { return view('admin.dashboard'); }
    public function orders() { return view('admin.orders'); }
    public function medicines() { return view('admin.medicines'); }
    public function users() { return view('admin.users'); }
}
