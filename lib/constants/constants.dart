const baseUrl = 'http://192.168.94.208:8000/api';
const loginUrl = '$baseUrl/login-mobile';
const logoutUrl = '$baseUrl/logoutMobile';
const userUrl = '$baseUrl/user';
//admin
const dashboardUrl = '$baseUrl/dashboard-datas';
const purchaseOrderUrl = '$baseUrl/purchase-order';
const productStocks = '$baseUrl/show-stocks';
const storeStocks = '$baseUrl/storestock';
//toBeAnnnounced
const getDataFromBarcodeUrl = '$baseUrl/product-id/';
const fetchQrCodeData = '$baseUrl/qrcode/';

const stockInRoute = '$baseUrl/stockin';
const stockOutRoute = '$baseUrl/stockout';
const returnDamageStockRoute = '$baseUrl/returnindamage';
const returnInExchangeStockRoute = '$baseUrl/returninexchange';
//Staff
const postOrder = '$baseUrl/addproduct';