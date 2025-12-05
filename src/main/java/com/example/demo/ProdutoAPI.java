package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("produtos")
@CrossOrigin(origins = "*")
public class ProdutoAPI {
	
	@Autowired
	ProdutoDAO dao;
	
	@GetMapping
	public List<Produto> obterTodos(){
		return dao.findAll();
	}
	
	@GetMapping("{codigo}")
	public Produto obter(@PathVariable Integer codigo){
		return dao.findById(codigo).get();
	}
	
	@DeleteMapping("{codigo}")
	public void excluir(@PathVariable Integer codigo){
		dao.deleteById(codigo);
	}
	
	@PostMapping
	public void inserir(@RequestBody Produto produto){
		dao.save(produto);
	}
	
	@PutMapping("{codigo}")		
	public void alterar(@PathVariable Integer codigo, @RequestBody Produto produto){
		if(codigo==produto.codigo)
			dao.save(produto); 
	}

}
