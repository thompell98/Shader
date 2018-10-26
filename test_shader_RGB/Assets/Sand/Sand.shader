Shader "Custom/Sand" {
	Properties {
		
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_ScrollSpeed("Scroll speed", Range(0,100)) = 10
	}
	SubShader {
		Tags {"Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 300

		CGPROGRAM
	
		#pragma surface surf Standard fullforwardshadows alpha:fade

		#pragma target 4.6

		sampler2D _MainTex;
		struct Input {
			float2 uv_MainTex;
		};
		half _Glossiness;
		half _Metallic;
		half _ScrollSpeed;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed2 scrolledUV = IN.uv_MainTex;

			fixed scrollValue = _ScrollSpeed * _Time;
			scrolledUV += fixed2(scrollValue, 0);

			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * tex2D (_MainTex, scrolledUV);
			o.Albedo = c.rgb;
		
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = (c.r+c.g+c.b);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
