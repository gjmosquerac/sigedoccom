<?php

namespace App\Http\Controllers;

use App\Models\Log;
use Illuminate\Http\Request;

class LogController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Log::latest()->get();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $log = new Log();
        $log->user = auth()->user()->email ?? 'Invitado';
        $log->ip = $request->ip();
        $log->agent = $request->userAgent();
        $log->timestamp = now();
        $log->evento = '🔐 Login institucional por WhatsApp';
        $log->save();

        return response()->json(['status' => '✅ Log institucional guardado']);
    }

    /**
     * Display the specified resource.
     */
    public function show(Log $log)
    {
        return $log;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Log $log)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Log $log)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Log $log)
    {
        $log->delete();
        return response()->json(['status' => '🗑️ Log eliminado']);
    }
}
