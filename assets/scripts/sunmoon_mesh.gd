@tool
extends MeshInstance3D
var arr_mesh = ArrayMesh.new()
var arrays = []

func _process(_delta: float) -> void:
  var vertices = PackedVector3Array()
  vertices.push_back(Vector3(1, 1, 0))
  vertices.push_back(Vector3(1, 0, 0))
  vertices.push_back(Vector3(1, 1, 1))
  #vertices.push_back(Vector3(1, 0, 1))
  #vertices.push_back(Vector3(1, 0, 0))
  #vertices.push_back(Vector3(1, 1, 1))
  #
  #var uv = PackedVector2Array()
  #uv.push_back(Vector2(0, 0))  # Top-left
  #uv.push_back(Vector2(0, 1))  # Bottom-left
  #uv.push_back(Vector2(1, 1))  # Bottom-right
  #uv.push_back(Vector2(1, 0))  # Top-right
  
  #var indices = PackedInt32Array([0, 1, 2, 1, 2, 3])
  
  # Initialize the ArrayMesh.
  #arrays.resize(Mesh.ARRAY_MAX)
  #arrays[Mesh.ARRAY_VERTEX] = vertices
  #arrays[Mesh.ARRAY_TEX_UV] = uv
  #arrays[Mesh.ARRAY_INDEX] = indices

  # Create the Mesh.
  arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
  mesh = arr_mesh
