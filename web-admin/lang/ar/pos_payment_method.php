<?php

use App\Enums\PosPaymentMethod;

return [
    PosPaymentMethod::CARD => 'بطاقة',
    PosPaymentMethod::CASH => 'نقداً',
    PosPaymentMethod::OTHER => 'آخر',
    PosPaymentMethod::MOBILE_BANKING => 'MFS'
];