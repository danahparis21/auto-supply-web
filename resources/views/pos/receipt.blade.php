<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt #{{ $invoice->invoice_number }} - Joy Jeffrey Auto Supply</title>
    <style>
        /* Thermal POS Receipt Styling (Standard 80mm roll) */
        @page {
            size: 80mm auto;
            margin: 3mm 4mm;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Courier New', Courier, monospace, system-ui;
            font-size: 13px;
            line-height: 1.35;
            color: #000;
            background: #fff;
            padding: 16px 12px;
            max-width: 300px;
            margin: 0 auto;
        }

        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .text-left { text-align: left; }
        .font-bold { font-weight: bold; }
        .font-extrabold { font-weight: 800; }

        .divider {
            border-bottom: 1.5px dashed #000;
            margin: 8px 0;
        }

        .divider-solid {
            border-bottom: 1.5px solid #000;
            margin: 8px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 6px 0;
        }

        th, td {
            padding: 3px 0;
            vertical-align: top;
        }

        th {
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        .action-bar {
            margin-bottom: 14px;
            text-align: center;
        }

        .btn {
            background: #9f1212;
            color: #fff;
            padding: 7px 16px;
            border-radius: 6px;
            text-decoration: none;
            cursor: pointer;
            font-size: 12px;
            font-weight: 700;
            font-family: sans-serif;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

        .btn:hover {
            background: #7f0c0c;
        }

        .btn-close {
            background: #4b5563;
            margin-left: 6px;
        }

        .btn-close:hover {
            background: #374151;
        }

        @media print {
            .action-bar {
                display: none !important;
            }
            body {
                padding: 0 !important;
                margin: 0 auto !important;
                width: 100% !important;
                max-width: 80mm !important;
                font-size: 13px !important;
            }
        }
    </style>
</head>
<body>

    <div class="action-bar">
        <button onclick="window.print()" class="btn">
            🖨️ Print Receipt
        </button>
        <button onclick="window.close()" class="btn btn-close">Close</button>
    </div>

    <!-- Shop Header -->
    <div class="text-center">
        <h1 style="font-size: 16px; font-weight: 900; letter-spacing: 0.5px; text-transform: uppercase;">JOY JEFFREY AUTO SUPPLY</h1>
        <p style="font-size: 11px; font-weight: 600; margin-top: 2px;">High Performance Auto Parts &amp; Lubricants</p>
        <p style="font-size: 10px; color: #333;">Nasugbu, Batangas, Philippines</p>
        <p style="font-size: 10px; color: #333;">Tel: (043) 740-0000 / 0917-123-4567</p>
    </div>

    <div class="divider"></div>

    <!-- Metadata -->
    <div style="font-size: 11px; line-height: 1.4;">
        <div style="display: flex; justify-content: space-between;">
            <span class="font-bold">INVOICE:</span>
            <span class="font-bold">{{ $invoice->invoice_number }}</span>
        </div>
        <div style="display: flex; justify-content: space-between;">
            <span>DATE:</span>
            <span>{{ $invoice->date->format('M d, Y') }} {{ $invoice->time }}</span>
        </div>
        <div style="display: flex; justify-content: space-between;">
            <span>CASHIER:</span>
            <span>{{ $invoice->user?->name ?? 'Admin' }}</span>
        </div>
    </div>

    <div class="divider"></div>

    <!-- Line Items Table -->
    <table>
        <thead>
            <tr style="border-bottom: 1px solid #000;">
                <th align="left" style="width: 50%;">ITEM</th>
                <th class="text-center" style="width: 15%;">QTY</th>
                <th class="text-right" style="width: 17%;">PRICE</th>
                <th class="text-right" style="width: 18%;">TOTAL</th>
            </tr>
        </thead>
        <tbody>
            @foreach($invoice->sales as $sale)
                <tr>
                    <td colspan="4" class="font-bold" style="padding-top: 4px; font-size: 12px;">
                        {{ $sale->product->product_name ?? 'Auto Part' }}
                    </td>
                </tr>
                <tr style="border-bottom: 1px dotted #ccc;">
                    <td style="font-size: 10px; color: #444;">
                        {{ $sale->product->type ? '[' . $sale->product->type . ']' : '' }} {{ $sale->product->brand ?? '' }}
                    </td>
                    <td class="text-center font-bold">{{ $sale->quantity_sold }}</td>
                    <td class="text-right">₱{{ number_format($sale->purchase_sale, 2) }}</td>
                    <td class="text-right font-bold">₱{{ number_format($sale->subtotal, 2) }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <div class="divider"></div>

    <!-- Totals Summary -->
    <div style="line-height: 1.5; font-size: 12px;">
        <div style="display: flex; justify-content: space-between;">
            <span>SUBTOTAL:</span>
            <span>₱{{ number_format($invoice->total_sales, 2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; font-weight: 900; font-size: 15px; margin: 3px 0; padding-top: 2px; border-top: 1px dashed #000;">
            <span>TOTAL AMOUNT:</span>
            <span>₱{{ number_format($invoice->total_sales, 2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; margin-top: 2px;">
            <span>CASH TENDERED:</span>
            <span>₱{{ number_format($invoice->customer_payment, 2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; font-weight: bold; font-size: 13px;">
            <span>CHANGE:</span>
            <span>₱{{ number_format($invoice->customer_change, 2) }}</span>
        </div>
    </div>

    <div class="divider"></div>

    <!-- Footer Note -->
    <div class="text-center" style="font-size: 10px; margin-top: 10px; line-height: 1.4;">
        <p>Thank you for choosing</p>
        <p class="font-bold" style="font-size: 11px;">JOY JEFFREY AUTO SUPPLY!</p>
        <p style="margin-top: 2px;">Please keep this receipt for warranty claims.</p>
        <p style="margin-top: 4px; font-size: 9px; color: #666;">Generated on {{ now()->format('Y-m-d H:i') }}</p>
    </div>

    <!-- Automatic Chrome Print Trigger -->
    <script>
        window.addEventListener('DOMContentLoaded', function () {
            // Automatically launch the Chrome print popup when page loads
            setTimeout(function () {
                window.print();
            }, 300);
        });
    </script>
</body>
</html>
