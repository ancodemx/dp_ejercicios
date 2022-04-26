package com.example.ejercicio_3;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class ActivityWeb extends AppCompatActivity {

    WebView wv1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_web);

        wv1 = (WebView)findViewById(R.id.wv1);

        String URL = getIntent().getStringExtra("sitioWeb");
        wv1.setWebViewClient(new WebViewClient());
        wv1.loadUrl("https://" + URL);
    }

    public void Cerrar(View view) {
        finish();
    }
}