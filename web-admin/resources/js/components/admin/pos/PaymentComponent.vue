<template>
    <LoadingComponent :props="loading" />

    <div id="orderpayment" class="modal">
        <div class="modal-dialog max-w-[428px] w-full">
            <div class="modal-header pb-3 border-b border-[#D9DBE9]">
                <h3 class="capitalize font-medium">Order Payment</h3>
                <button class="modal-close fa-regular fa-circle-xmark" @click="reset"></button>
            </div>
            <div class="modal-body">
                <div class="mb-4">
                    <div
                        class="flex justify-between items-center h-12 w-full rounded-lg py-1.5 px-2 placeholder:text-[10px] placeholder:text-[#6E7191] bg-[#F7F7FC]">
                        <span class="text-sm font-normal text-[#2E2F38]">Total Amount</span>
                        <span class="text-primary text-base font-medium">{{
                            currencyFormat(props.form.total,
                                setting.site_digit_after_decimal_point, setting.site_default_currency_symbol,
                                setting.site_currency_position)
                        }}</span>
                    </div>
                </div>
                <div class="mb-4">
                    <h3 class="capitalize font-medium mb-2">Select Payment Method</h3>
                    <nav class="flex flex-wrap gap-4 active-group">
                        <button data-tab="#cash" type="button"
                            class="other-tabBtn w-fit flex flex-col items-center gap-2 rounded-lg py-3 px-7 border bg-[#F7F7FC] border-[#F7F7FC]"
                            :class="props.form.pos_payment_method === posPaymentMethodEnum.CASH ? 'active' : ''"
                            @click="paymentMethod(posPaymentMethodEnum.CASH, 'cashInput')">
                            <i class="lab lab-cash lab-font-size-24"></i>
                            <span class="text-xs font-normal leading-none text-heading">{{ $t("label.cash") }}</span>
                        </button>
                        <button data-tab="#card" type="button"
                            class="other-tabBtn w-fit flex flex-col items-center gap-2 rounded-lg py-3 px-7 border bg-[#F7F7FC] border-[#F7F7FC]"
                            :class="props.form.pos_payment_method === posPaymentMethodEnum.CARD ? 'active' : ''"
                            @click="paymentMethod(posPaymentMethodEnum.CARD, 'cardInput')">
                            <i class="lab lab-card-2 lab-font-size-24"></i>
                            <span class="text-xs font-normal leading-none text-heading">{{ $t("label.card") }}</span>
                        </button>
                        <button data-tab="#mfs" type="button" onclick="createkeyboard('mfs')"
                            class="other-tabBtn w-fit flex flex-col items-center gap-2 rounded-lg py-3 px-7 border bg-[#F7F7FC] border-[#F7F7FC]"
                            :class="props.form.pos_payment_method === posPaymentMethodEnum.MOBILE_BANKING ? 'active' : ''"
                            @click="paymentMethod(posPaymentMethodEnum.MOBILE_BANKING)">
                            <i class="lab lab-mfs lab-font-size-24"></i>
                            <span class="text-xs font-normal leading-none text-heading">{{ $t("label.mobile_banking")
                            }}</span>
                        </button>
                        <button data-tab="#otherpay" type="button" onclick="createkeyboard('otherpay')"
                            class="other-tabBtn w-fit flex flex-col items-center gap-2 rounded-lg py-3 px-7 border bg-[#F7F7FC] border-[#F7F7FC]"
                            :class="props.form.pos_payment_method === posPaymentMethodEnum.OTHER ? 'active' : ''"
                            @click="paymentMethod(posPaymentMethodEnum.OTHER)">
                            <i class="lab lab-other lab-font-size-24"></i>
                            <span class="text-xs font-normal leading-none text-heading">{{ $t("label.other") }}</span>
                        </button>
                    </nav>
                </div>
                <div id="cash" class="data-tab hidden"
                    :class="props.form.pos_payment_method === posPaymentMethodEnum.CASH ? 'active' : ''">
                    <div class="mb-4">
                        <h3 class="capitalize font-medium mb-2">{{ $t("label.received_amount") }}</h3>
                        <input id="cashInput" ref="cashInput" type="text" v-on:keypress="floatNumber($event)"
                            class="h-12 w-full rounded-lg border py-1.5 px-4 border-[#D9DBE9] text-black">
                    </div>
                </div>
                <div id="card" class="data-tab hidden"
                    :class="props.form.pos_payment_method === posPaymentMethodEnum.CARD ? 'active' : ''">
                    <div class="mb-4">
                        <h3 class="capitalize font-medium mb-2">{{ $t('label.enter_card_last_4_digits') }}</h3>
                        <input id="cardInput" type="number" ref="cardInput"
                            class="h-12 w-full rounded-lg border py-1.5 px-4 border-[#D9DBE9] text-black" required>
                    </div>
                </div>

                <div id="mfs" class="data-tab hidden"
                    :class="props.form.pos_payment_method === posPaymentMethodEnum.MOBILE_BANKING ? 'active' : ''">
                    <div class="mb-4">
                        <h3 class="capitalize font-medium mb-2">{{ $t('label.enter_transaction_id') }}</h3>
                        <input id="mfs-trans" type="text" ref="mfsInput"
                            class="h-12 w-full rounded-lg border py-1.5 px-4 placeholder:text-xs border-[#D9DBE9]">
                    </div>
                    <div class="board grid grid-cols-10 justify-between gap-1.5 mb-6"></div>
                </div>
                <div id="otherpay" class="data-tab hidden"
                    :class="props.form.pos_payment_method === posPaymentMethodEnum.OTHER ? 'active' : ''">
                    <div class="mb-4">
                        <h3 class="capitalize font-medium mb-2">{{ $t('label.enter_payment_note') }}</h3>
                        <input id="other-trans" type="text" ref="otherInput"
                            class="h-12 w-full rounded-lg border py-1.5 px-4 placeholder:text-xs border-[#D9DBE9]">
                    </div>
                    <div class="board grid grid-cols-10 justify-between gap-1.5 mb-6"></div>
                </div>

                <div class="grid grid-cols-4 gap-x-4 gap-y-3.5 mb-6"
                    v-if="props.form.pos_payment_method === posPaymentMethodEnum.CASH || props.form.pos_payment_method === posPaymentMethodEnum.CARD">
                    <button :onclick="`solve('1', '${inputIdName}')`" value="1"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">1</button>
                    <button :onclick="`solve('2', '${inputIdName}')`" value="2"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">2</button>
                    <button :onclick="`solve('3', '${inputIdName}')`" value="3"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">3</button>
                    <button :onclick="`Back('${inputIdName}')`" value="cut"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39] row-span-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                            <path
                                d="M16.9997 3.75H10.2797C8.86969 3.75 7.52969 4.34 6.57969 5.39L3.04969 9.27C1.63969 10.82 1.63969 13.18 3.04969 14.73L6.57969 18.61C7.52969 19.65 8.86969 20.25 10.2797 20.25H16.9997C19.7597 20.25 21.9997 18.01 21.9997 15.25V8.75C21.9997 5.99 19.7597 3.75 16.9997 3.75ZM16.5297 13.94C16.8197 14.23 16.8197 14.71 16.5297 15C16.3797 15.15 16.1897 15.22 15.9997 15.22C15.8097 15.22 15.6197 15.15 15.4697 15L13.5297 13.06L11.5897 15C11.4397 15.15 11.2497 15.22 11.0597 15.22C10.8697 15.22 10.6797 15.15 10.5297 15C10.2397 14.71 10.2397 14.23 10.5297 13.94L12.4697 12L10.5297 10.06C10.2397 9.77 10.2397 9.29 10.5297 9C10.8197 8.71 11.2997 8.71 11.5897 9L13.5297 10.94L15.4697 9C15.7597 8.71 16.2397 8.71 16.5297 9C16.8197 9.29 16.8197 9.77 16.5297 10.06L14.5897 12L16.5297 13.94Z"
                                fill="#1F1F39" />
                        </svg>
                    </button>
                    <button :onclick="`solve('4', '${inputIdName}')`" value="4"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">4</button>
                    <button :onclick="`solve('5', '${inputIdName}')`" value="5"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">5</button>
                    <button :onclick="`solve('6', '${inputIdName}')`" value="6"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">6</button>
                    <button :onclick="`solve('7', '${inputIdName}')`" value="7"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">7</button>
                    <button :onclick="`solve('8', '${inputIdName}')`" value="8"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">8</button>
                    <button :onclick="`solve('9', '${inputIdName}')`" value="9"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">9</button>
                    <button :onclick="`Clear('${inputIdName}')`" value="clear" type="reset"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39] row-span-2">
                        Clear
                    </button>
                    <button :onclick="`solve('00', '${inputIdName}')`" value="00"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">00</button>
                    <button :onclick="`solve('0', '${inputIdName}')`" value="0"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">0</button>
                    <button :onclick="`solve('.', '${inputIdName}')`" value="point"
                        class="num bg-[#F7F7FC] rounded-lg p-2.5 flex items-center justify-center text-base font-medium text-[#1F1F39]">.</button>
                </div>
                <button @click="confirmOrder" type="button"
                    class="rounded-3xl text-base py-2 px-3 font-medium w-full text-white bg-primary">Confirm & Print
                    Reciept</button>
            </div>
        </div>
    </div>

    <ReceiptComponent :order="order" />
</template>
<script>
import LoadingComponent from "../components/LoadingComponent";
import appService from "../../../services/appService";
import alertService from "../../../services/alertService";
import ReceiptComponent from "./ReceiptComponent";
import posPaymentMethodEnum from "../../../enums/modules/posPaymentMethodEnum";
import sourceEnum from "../../../enums/modules/sourceEnum";
import isAdvanceOrderEnum from "../../../enums/modules/isAdvanceOrderEnum";
import orderTypeEnum from "../../../enums/modules/orderTypeEnum";

export default {
    name: "PaymentComponent",
    components: { LoadingComponent, ReceiptComponent },
    props: {
        props: Object,
    },
    data() {
        return {
            loading: {
                isActive: false,
            },
            order: {},
            posPaymentMethodEnum: posPaymentMethodEnum,
            inputIdName: "cashInput"
        };
    },
    computed: {
        setting: function () {
            return this.$store.getters['frontendSetting/lists'];
        },
    },
    mounted() {
    },
    methods: {
        currencyFormat: function (amount, decimal, currency, position) {
            return appService.currencyFormat(amount, decimal, currency, position);
        },
        floatNumber(e) {
            return appService.floatNumber(e);
        },
        reset: function () {
            Object.keys(this.$refs).forEach(refName => {
                if (this.$refs[refName].value !== undefined) {
                    this.$refs[refName].value = "";
                }
            });
            this.$props.props.form.pos_payment_note = "";
            appService.modalHide('#orderpayment');
        },
        paymentMethod: function (method, Idname = "") {
            if (Idname) {
                this.inputIdName = Idname;
            }

            Object.keys(this.$refs).forEach(refName => {
                if (this.$refs[refName].value !== undefined) {
                    this.$refs[refName].value = "";
                }
            });
            this.$props.props.form.pos_payment_method = method;
            this.$props.props.form.pos_payment_note = "";
        },
        confirmOrder: function () {
            try {
                if (this.$props.props.form.pos_payment_method === this.posPaymentMethodEnum.CASH && this.$refs.cashInput.value) {
                    this.$props.props.form.pos_received_amount = this.$refs.cashInput.value;
                } else {
                    this.$props.props.form.pos_received_amount = null;
                }

                if (this.$props.props.form.pos_payment_method === this.posPaymentMethodEnum.CARD && this.$refs.cardInput.value) {
                    this.$props.props.form.pos_payment_note = this.$refs.cardInput.value;
                } else if (this.$props.props.form.pos_payment_method === this.posPaymentMethodEnum.MOBILE_BANKING && this.$refs.mfsInput.value) {
                    this.$props.props.form.pos_payment_note = this.$refs.mfsInput.value;
                } else if (this.$props.props.form.pos_payment_method === this.posPaymentMethodEnum.OTHER && this.$refs.otherInput.value) {
                    this.$props.props.form.pos_payment_note = this.$refs.otherInput.value;
                } else {
                    this.$props.props.form.pos_payment_note = "";
                }

                this.$store.dispatch("defaultAccess/show").then((res) => {
                    this.$props.props.form.branch_id = res.data.data.branch_id;
                    this.$store.dispatch('posOrder/save', this.$props.props.form).then(orderResponse => {
                        this.$props.props.form.token = "";
                        this.$props.props.form.subtotal = null;
                        this.$props.props.form.discount = 0;
                        this.$props.props.form.delivery_time = null;
                        this.$props.props.form.delivery_charge = null;
                        this.$props.props.form.total = 0;
                        this.$props.props.form.order_type = orderTypeEnum.DINING_TABLE;
                        this.$props.props.form.is_advance_order = isAdvanceOrderEnum.NO;
                        this.$props.props.form.source = sourceEnum.POS;
                        this.$props.props.form.address_id = null;
                        this.$props.props.form.dining_table_id = null;
                        this.$props.props.form.coupon_id = null;
                        this.$props.props.form.items = [];
                        this.$props.props.form.pos_payment_method = this.posPaymentMethodEnum.CASH;
                        this.$props.props.form.pos_payment_note = null;
                        this.$props.props.form.pos_received_amount = null;
                        appService.modalHide('#orderpayment');
                        this.$store.dispatch('posCart/resetCart').then(res => {
                            this.loading.isActive = false;
                        }).catch();
                        this.$store.dispatch('posOrder/show', orderResponse.data.data.id).then(res => {
                            this.order = res.data.data;
                            this.loading.isActive = false;
                        }).catch((error) => {
                            this.loading.isActive = false;
                            alertService.error(error.response.data.message);
                        });
                        this.reset();
                        appService.modalShow('#receiptModal');
                    }).catch((err) => {
                        this.loading.isActive = false;
                        if (typeof err.response.data.errors === 'object') {
                            _.forEach(err.response.data.errors, (error) => {
                                alertService.error(error[0]);
                            });
                        }
                    });
                }).catch((err) => {
                    this.loading.isActive = false;
                });

            } catch (err) {
                this.loading.isActive = false;
                alertService.error(err);
            }
        },
    },
};
</script>