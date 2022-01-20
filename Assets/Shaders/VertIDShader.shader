Shader "Unlit/VertIDShader"
{
      Properties
    {
        _Red ("Red",Range(0,1)) = 0.5
        _Green ("Green",Range(0,1)) = 0.5
        _Blue ("Blue",Range(0,1)) = 0.5
        _Color ("Color",Color) = (1,1,1,1)
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.5

            struct v2f {
                fixed4 color : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            float _Red;
            float _Green;
            float _Blue;
            fixed4 _Color;

            v2f vert (
                float4 vertex : POSITION, // vertex position input
                uint vid : SV_VertexID // vertex ID, needs to be uint
                )
            {
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                // output funky colors based on vertex ID
                float f = (float)vid;
                o.color =  half4(sin(f/_Red),cos(f/_Green),f/ tan(f/_Blue),0) * _Color + _Color;
                //o.color = half4(sin(f/10),sin(f/100),sin(f/1000),0) * 0.5 + 0.5;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
}