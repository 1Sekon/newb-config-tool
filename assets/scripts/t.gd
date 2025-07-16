@tool
extends MeshInstance3D

var arr_mesh = ArrayMesh.new()
var arrays = []

func _process(_delta: float) -> void:
  var texture = load("res://your_texture.png")
  var image = texture.get_image()
  var pixels = image.get_data()

  var vertices = PackedVector3Array()
  var uvs = PackedVector2Array()
  var indices = PackedInt32Array()

  var vertex_index = 0

  for y in range(image.get_height()):
      for x in range(image.get_width()):
          var pixel_color = image.get_pixel(x, y)
          if pixel_color.a > 0:  # Check if pixel is not transparent
              # Create vertices for the pixel
              vertices.push_back(Vector3(x, 0, y))
              vertices.push_back(Vector3(x + 1, 0, y))
              vertices.push_back(Vector3(x + 1, 0, y + 1))
              vertices.push_back(Vector3(x, 0, y + 1))
              
              # Create UVs for the pixel
              uvs.push_back(Vector2(x / image.get_width(), y / image.get_height()))
              uvs.push_back(Vector2((x + 1) / image.get_width(), y / image.get_height()))
              uvs.push_back(Vector2((x + 1) / image.get_width(), (y + 1) / image.get_height()))
              uvs.push_back(Vector2(x / image.get_width(), (y + 1) / image.get_height()))
              
              # Create indices for the pixel
              indices.push_back(vertex_index)
              indices.push_back(vertex_index + 1)
              indices.push_back(vertex_index + 2)
              indices.push_back(vertex_index)
              indices.push_back(vertex_index + 2)
              indices.push_back(vertex_index + 3)
              vertex_index += 4
  
  arrays.resize(Mesh.ARRAY_MAX)
  arrays[Mesh.ARRAY_VERTEX] = vertices
  arrays[Mesh.ARRAY_TEX_UV] = uvs
  arrays[Mesh.ARRAY_INDEX] = indices
  arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

  mesh = arr_mesh