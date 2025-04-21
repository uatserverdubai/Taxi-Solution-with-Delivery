<?php

use App\Enums\PosPaymentMethod;

return [
    PosPaymentMethod::CARD => 'Card',
    PosPaymentMethod::CASH => 'Cash',
    PosPaymentMethod::OTHER => 'Other',
    PosPaymentMethod::MOBILE_BANKING => 'MFS'
];