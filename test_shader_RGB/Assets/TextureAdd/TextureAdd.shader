Shader "Custom/TextureAdd" {
	Properties {
		_Tex1 ("Texture1", 2D) = "white" {}
		_Tex2 ("Texture2", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		
	}
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 100

			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows
			#pragma target 3.0

			sampler2D _Tex1;
			sampler2D _Tex2;
			half _Glossiness;
			half _Metallic;

			struct Input {
				float2 uv_Tex1;
			};

			
			void surf(Input IN, inout SurfaceOutputStandard o) {

				fixed4 c = pow(tex2D(_Tex1, IN.uv_Tex1),4) * tex2D(_Tex2, IN.uv_Tex1);
				o.Albedo = c.rgb;

				o.Metallic = _Metallic;
				o.Smoothness = _Glossiness;
				o.Alpha = c.a;
			}
			ENDCG
		
	}
	FallBack "Diffuse"
}
