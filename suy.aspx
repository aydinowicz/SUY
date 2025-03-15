<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sosyal Yardım Uygunluk Kontrolü</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 24px;
        }
        .form-group {
            margin-bottom: 20px;
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            box-sizing: border-box;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #495057;
            font-weight: 500;
        }
        input[type="number"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.2s;
            box-sizing: border-box;
        }
        input[type="number"]:focus {
            outline: none;
            border-color: #80bdff;
            box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
        }
        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 15px 0;
            padding: 12px;
            background-color: #f8f9fa;
            border-radius: 6px;
            box-sizing: border-box;
        }
        .checkbox-container input[type="checkbox"] {
            width: 18px;
            height: 18px;
            margin: 0;
            cursor: pointer;
        }
        .checkbox-container label {
            margin: 0;
            display: inline;
            cursor: pointer;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 20px;
            transition: all 0.3s;
            box-sizing: border-box;
        }
        button:hover {
            background-color: #0056b3;
        }
        #sonuc {
            margin-top: 20px;
            padding: 15px;
            border-radius: 6px;
            word-wrap: break-word;
            box-sizing: border-box;
        }
        .uygun {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .uygun-degil {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .odeme-detay {
            margin-top: 15px;
            padding: 15px;
            background-color: #e9ecef;
            border-radius: 6px;
            border: 1px solid #dee2e6;
            box-sizing: border-box;
        }
        .odeme-detay p {
            margin: 8px 0;
            line-height: 1.5;
        }
        @media (max-width: 480px) {
            .container {
                padding: 15px;
            }
            h2 {
                font-size: 20px;
            }
            .form-group {
                padding: 10px;
            }
            input[type="number"] {
                width: calc(100% - 16px);
                padding: 8px;
            }
            .odeme-detay, #sonuc {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>SUY/T-SUY Uygunluk Kontrolü</h2>
        
        <div class="form-group">
            <label for="cocukSayisi">0-17 Yaş Arası Çocuk Sayısı:</label>
            <input type="number" id="cocukSayisi" min="0" value="0">
        </div>

        <div class="form-group">
            <label for="yetiskinErkek">18-64 Yaş Arası Erkek Sayısı:</label>
            <input type="number" id="yetiskinErkek" min="0" value="0">
        </div>

        <div class="form-group">
            <label for="yetiskinKadin">18-64 Yaş Arası Kadın Sayısı:</label>
            <input type="number" id="yetiskinKadin" min="0" value="0">
        </div>

        <div class="form-group">
            <label for="yasliSayisi">65 Yaş ve Üzeri Birey Sayısı:</label>
            <input type="number" id="yasliSayisi" min="0" value="0">
        </div>

        <div class="checkbox-container">
            <input type="checkbox" id="agirEngelli">
            <label for="agirEngelli">Hanede ağır engelli bulunmaktadır</label>
        </div>

        <div class="form-group" id="engelliSayisiDiv" style="display: none;">
            <label for="engelliSayisi">Ağır Engelli Birey Sayısı:</label>
            <input type="number" id="engelliSayisi" min="0" value="0">
        </div>

        <button onclick="hesapla()">Uygunluk Kontrolü Yap</button>

        <div id="sonuc"></div>
    </div>

    <script>
        document.getElementById('agirEngelli').addEventListener('change', function() {
            const engelliSayisiDiv = document.getElementById('engelliSayisiDiv');
            const engelliSayisiInput = document.getElementById('engelliSayisi');
            
            if (this.checked) {
                engelliSayisiDiv.style.display = 'block';
            } else {
                engelliSayisiDiv.style.display = 'none';
                engelliSayisiInput.value = '0';
            }
        });

        function hesapla() {
            const cocukSayisi = parseInt(document.getElementById('cocukSayisi').value) || 0;
            const yetiskinErkek = parseInt(document.getElementById('yetiskinErkek').value) || 0;
            const yasliSayisi = parseInt(document.getElementById('yasliSayisi').value) || 0;
            const yetiskinKadin = parseInt(document.getElementById('yetiskinKadin').value) || 0;
            const agirEngelli = document.getElementById('agirEngelli').checked;
            const engelliSayisi = agirEngelli ? (parseInt(document.getElementById('engelliSayisi').value) || 0) : 0;
            
            const sonucDiv = document.getElementById('sonuc');
            let uygun = false;
            let mesaj = '';

            const toplamBirey = cocukSayisi + yetiskinErkek + yasliSayisi + yetiskinKadin;
            const toplamYetiskin = yetiskinErkek + yetiskinKadin + yasliSayisi;
            
            let KISI_BASI_YARDIM = 500;
            if (yasliSayisi > 0 || agirEngelli) {
                KISI_BASI_YARDIM = 700;
            }
            
            const ENGELLI_EK_YARDIM = 2400;

            if (toplamYetiskin === 0) {
                sonucDiv.className = 'uygun-degil';
                sonucDiv.innerHTML = 'Hanede en az bir yetişkin birey (18 yaş ve üzeri) bulunmak zorundadır.';
                return;
            }

            if (yetiskinErkek > 0) {
                const oran = (cocukSayisi + yasliSayisi) / yetiskinErkek;
                uygun = oran >= 1.5;
                mesaj = uygun ? 
                    `Hane yardıma uygundur. Oran: ${oran.toFixed(2)}` : 
                    `Hane yardıma uygun değildir. Oran: ${oran.toFixed(2)} (1.5'ten küçük)`;
            } else {
                uygun = yetiskinKadin <= 2 && toplamBirey <= 6;
                mesaj = uygun ? 
                    'Hane yardıma uygundur.' : 
                    'Hane yardıma uygun değildir. (Yetişkin kadın sayısı 2\'den fazla veya toplam birey sayısı 6\'dan fazla)';
            }

            sonucDiv.className = uygun ? 'uygun' : 'uygun-degil';
            
            if (uygun) {
                const temelYardim = toplamBirey * KISI_BASI_YARDIM;
                const engelliYardim = engelliSayisi * ENGELLI_EK_YARDIM;
                const toplamYardim = temelYardim + engelliYardim;

                mesaj += `
                    <div class="odeme-detay">
                        <p>Toplam Hane Nüfusu: ${toplamBirey} kişi</p>
                        <p>Kişi Başı Yardım Tutarı: ${KISI_BASI_YARDIM.toLocaleString('tr-TR')} ₺</p>
                        <p>Temel Yardım Tutarı: ${temelYardim.toLocaleString('tr-TR')} ₺</p>`;
                
                if (agirEngelli) {
                    mesaj += `
                        <p>Ağır Engelli Sayısı: ${engelliSayisi} kişi</p>
                        <p>Engelli Ek Yardım Tutarı: ${engelliYardim.toLocaleString('tr-TR')} ₺</p>`;
                }

                if (yasliSayisi > 0) {
                    mesaj += `<p>Not: 65 yaş ve üzeri birey bulunduğu için kişi başı yardım tutarı 700₺ olarak hesaplanmıştır.</p>`;
                }

                mesaj += `
                        <p><strong>Toplam Yardım Tutarı: ${toplamYardim.toLocaleString('tr-TR')} ₺</strong></p>
                    </div>`;
            }
            
            sonucDiv.innerHTML = mesaj;
        }
    </script>
</body>
</html>














