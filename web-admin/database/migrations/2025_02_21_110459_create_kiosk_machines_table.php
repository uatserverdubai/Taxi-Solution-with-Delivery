<?php

use App\Enums\Ask;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('kiosk_machines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('branch_id')->constrained('branches');
            $table->string('machine_id');
            $table->string('username');
            $table->string('password');
            $table->string('device_token')->nullable();
            $table->tinyInteger('is_login')->nullable()->default(Ask::NO);
            $table->unsignedTinyInteger('status')->default(\App\Enums\Status::ACTIVE)->comment(\App\Enums\Status::ACTIVE . '=' . trans('statuse.' . \App\Enums\Status::ACTIVE) . ', ' . \App\Enums\Status::INACTIVE . '=' . trans('statuse.' . \App\Enums\Status::INACTIVE));
            $table->string('creator_type',)->nullable();
            $table->bigInteger('creator_id',)->nullable();
            $table->string('editor_type',)->nullable();
            $table->bigInteger('editor_id',)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('kiosk_machines');
    }
};
