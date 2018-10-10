using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WheelTracks : MonoBehaviour {
    public Shader _drawShader;
    public GameObject _terrain;
    public Transform[] _wheel;
    RaycastHit _groundHit;
    int _layerMask;
    [Range(0, 4)]
    public float _brushSize;
    [Range(0, 1)]
    public float _brushStrength;

    private RenderTexture _splatmap;
    private Material _snowMaterial, _drawMaterial;

    // Use this for initialization
    void Start () {
        _layerMask = LayerMask.GetMask("Ground");
        _drawMaterial = new Material(_drawShader);
        _snowMaterial = _terrain.GetComponent<MeshRenderer>().material;
        _splatmap = new RenderTexture(1024, 1024, 0, RenderTextureFormat.ARGBFloat);
        _snowMaterial.SetTexture("_Splat", _splatmap);
    }
	
	// Update is called once per frame
	void Update () {
		foreach(Transform wheel in _wheel) {
            if (Physics.Raycast(wheel.position, Vector3.down, out _groundHit, 1f, _layerMask)) {
                _drawMaterial.SetVector("_Coordinate", new Vector4(_groundHit.textureCoord.x, _groundHit.textureCoord.y, 0, 0));
                _drawMaterial.SetFloat("_Strength", _brushStrength);
                _drawMaterial.SetFloat("_Size", _brushSize);
                RenderTexture temp = RenderTexture.GetTemporary(_splatmap.width, _splatmap.height, 0, RenderTextureFormat.ARGBFloat);
                Graphics.Blit(_splatmap, temp);
                Graphics.Blit(temp, _splatmap, _drawMaterial);
                RenderTexture.ReleaseTemporary(temp);
            }
        }
	}
}
