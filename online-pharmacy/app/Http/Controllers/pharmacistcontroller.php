<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PharmacistController extends Controller
{
    public function pendingPrescriptions() { return view('pharmacist.pending_prescriptions'); }
    public function approveOrders() { return view('pharmacist.approve_orders'); }
    public function inventory() { return view('pharmacist.inventory'); }
}
