<?php

use App\Enums\PosPaymentMethod;

return [
    PosPaymentMethod::CARD => 'Kaart',
    PosPaymentMethod::CASH => 'Kasse',
    PosPaymentMethod::OTHER => 'Andere',
    PosPaymentMethod::MOBILE_BANKING => 'MFS'
];