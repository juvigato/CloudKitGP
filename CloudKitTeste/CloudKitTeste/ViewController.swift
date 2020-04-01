//
//  ViewController.swift
//  CloudKitTeste
//
//  Created by Juliana Vigato Pavan on 03/03/20.
//  Copyright © 2020 Juliana Vigato Pavan. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

//    let container = CKContainer.init(identifier: "iCloudCloudKitTeste")
    let container = CKContainer.default()
    lazy var db = container.privateCloudDatabase
    let predicado = NSPredicate(value: true)
    
    //posso criar um array e ja no inicio guardar todos os alunos -> bom pq performance mas mal pq sincornia
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cadastrarPessoas()
        
        //select * from (traz tudo) -> value: true
        
        let query = CKQuery(recordType: "Aluno", predicate: predicado)
        
        db.perform(query, inZoneWith: nil) { (records, error) in
//            print(records)
//            print(error)
        }
        
//        alterarDados()
        criarUniversidade()
        deletarDados()
    }
    
    func cadastrarPessoas() {
        var aluno = CKRecord(recordType: "Aluno")
//        aluno["Nome"] = "Nath"
        aluno.setValue("Nath", forKey: "Nome")
        aluno.setValue("Engenheria Elétrica", forKey: "Curso")
        aluno.setValue("31738555", forKey: "TIA")
        db.save(aluno, completionHandler: {_,_ in})
        
        aluno = CKRecord(recordType: "Aluno")
        aluno.setValue("Cássia", forKey: "Nome")
        aluno.setValue("CC", forKey: "Curso")
        aluno.setValue("31738553", forKey: "TIA")
        db.save(aluno, completionHandler: {_,_ in})
    }
    
    func alterarDados() {
        let predicadoCassia = NSPredicate(format: "Nome == 'Cássia'")
        let queryCassia = CKQuery(recordType: "Aluno", predicate: predicadoCassia)
        db.perform(queryCassia, inZoneWith: nil) { (records, error) in
            
            records?[0].setValue("Jurema", forKey: "Nome")
            self.db.save((records![0]), completionHandler: {_,_ in})
            print(records?[0].value(forKey: "Nome"))
        }
    }
    
    func deletarDados() {
        let predicadoJurema = NSPredicate(format: "Nome == 'Cássia' AND Curso == 'CC'")
        let queryJurema = CKQuery(recordType: "Aluno", predicate: predicadoJurema)
        db.perform(queryJurema, inZoneWith: nil) { (record, error) in
            let recordID = record?.first?.recordID
            self.db.delete(withRecordID: recordID!, completionHandler: {_,_ in})
        }
        print("foi?")
    }
    
    func referencia() {
        let predicadoNath = NSPredicate(format: "Nome == 'Nath'")
        let queryNath = CKQuery(recordType: "Aluno", predicate: predicadoNath)
        db.perform(queryNath, inZoneWith: nil) { (record, error) in
            
        }
    }
    
    func criarUniversidade() {
        var facul = CKRecord(recordType: "Universidade")
        facul.setValue("Mack", forKey: "Nome")
        db.save(facul, completionHandler: {_,_ in})
    }
}
