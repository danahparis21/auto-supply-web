<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt #{{ $invoice->invoice_number }} - Joy Jeffrey Auto Supply</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Courier New', Courier, monospace;
            font-size: 12px;
            color: #000;
            background: #fff;
            padding: 20px;
            max-width: 320px;
            margin: 0 auto;
        }
        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .font-bold { font-weight: bold; }
        .divider {
            border-bottom: 1px dashed #000;
            margin: 8px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 8px 0;
        }
        th, td {
            padding: 3px 0;
        }
        .action-bar {
            margin-bottom: 15px;
            text-align: center;
        }
        .btn {
            background: #000;
            color: #fff;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            font-size: 11px;
            font-family: sans-serif;
            border: none;
        }
        @media print {
            .action-bar { display: none; }
            body { padding: 0; margin: 0; width: 100%; }
        }
    </style>
</head>
<body>

    <div class="action-bar">
        <button onclick="window.print()" class="btn">Print Receipt</button>
        <button onclick="window.close()" class="btn" style="background:#666;">Close</button>
    </div>

    <div class="text-center">
        <h2 style="font-size: 15px; font-weight: bold;">JOY JEFFREY AUTO SUPPLY</h2>
        <p style="font-size: 10px;">High Performance Auto Parts & Lubricants</p>
        <p style="font-size: 10px;">Nasugbu, Batangas, Philippines</p>
    </div>

    <div class="divider"></div>

    <div>
        <div><strong>INVOICE:</strong> {{ $invoice->invoice_number }}</div>
        <div><strong>DATE:</strong> {{ $invoice->date->format('M d, Y') }} {{ $invoice->time }}</div>
        <div><strong>CASHIER:</strong> {{ $invoice->user?->name ?? 'Admin' }}</div>
    </div>

    <div class="divider"></div>

    <table>
        <thead>
            <tr style="border-bottom: 1px solid #000;">
                <th align="left">ITEM</th>
                <th class="text-center">QTY</th>
                <th class="text-right">PRICE</th>
                <th class="text-right">TOTAL</th>
            </tr>
        </thead>
        <tbody>
            @foreach($invoice->sales as $sale)
                <tr>
                    <td colspan="4" class="font-bold">{{ $sale->product->product_name ?? 'Auto Part' }}</td>
                </tr>
                <tr>
                    <td style="font-size: 10px; color: #555;">{{ $sale->product->brand ?? '' }}</td>
                    <td class="text-center">{{ $sale->quantity_sold }}</td>
                    <td class="text-right">₱{{ number_format($sale->purchase_sale, 2) }}</td>
                    <td class="text-right font-bold">₱{{ number_format($sale->subtotal, 2) }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <div class="divider"></div>

    <div style="line-height: 1.6;">
        <div style="display: flex; justify-content: space-between;">
            <span>SUBTOTAL:</span>
            <span>₱{{ number_format($invoice->total_sales, 2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; font-weight: bold; font-size: 13px;">
            <span>TOTAL AMOUNT:</span>
            <span>₱{{ number_format($invoice->total_sales, 2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between;">
            <span>CASH TENDERED:</span>
            <span>₱{{ number_format($invoice->customer_payment, 2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; font-weight: bold;">
            <span>CHANGE:</span>
            <span>₱{{ number_format($invoice->customer_change, 2) }}</span>
        </div>
    </div>

    <div class="divider"></div>

    <div class="text-center" style="font-size: 10px; margin-top: 10px;">
        <p>Thank you for choosing</p>
        <p class="font-bold">Joy Jeffrey Auto Supply!</p>
        <p>Please keep this receipt for warranty.</p>
    </div>

</body>
</html>
