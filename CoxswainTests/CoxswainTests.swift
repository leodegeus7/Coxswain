//
//  CoxswainTests.swift
//  CoxswainTests
//
//  Created by Leonardo Geus on 26/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import XCTest
@testable import Coxswain

class CoxswainTests: XCTestCase {
    
    let cox = Coxswain()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testStringFinal() {
        let action = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol{1}")
        let finalString = action.1
        XCTAssert(finalString == "With functions to conforming to a protocol")
    }
    
    func testStringEntryWithPercent() {

        let actions = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol{1}")
        let action = actions.0.first!
        
        
        let actionEntry = ActionEntry(name: "1", percent: 0)
        XCTAssert(action.percent == actionEntry.percent)
    }
    
    func testStringEntryWithName() {
        let actions = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol{1}")
        let action = actions.0.first!
        let actionEntry = ActionEntry(name: "1", percent: 0)
        XCTAssert(action.name == actionEntry.name)
    }
    
    func testStringEntryWithPercentInTheFinal() {
        let actions = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol{1}")
        let action = actions.0.first!
        let actionEntry = ActionEntry(name: "1", percent: 0)
        XCTAssert(action.percent == actionEntry.percent)
    }
    
    func testStringEntryWithNameInTheFinal() {
        let actions = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol{1}")
        let action = actions.0.first!
        let actionEntry = ActionEntry(name: "1", percent: 0)
        XCTAssert(action.name == actionEntry.name)
    }
    
    func testStringEntryToTestIfPercentChanges() {
        let actions = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol{1}")
        let actions2 = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol")
        
        let action = actions.0[3]
        let action2 = actions2.0[3]
        
        XCTAssert(action.percent == action2.percent)
    }
    
    func testStringEntryToTestIfPercentChangesSecond() {
        let actions = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to a protocol{1}")
        let actions2 = cox.findActionsInText(text: "{1}With{0} functions to {1}conforming {2}to {44477770}a protocol")
        
        let action = actions.0[3]
        let action2 = actions2.0[3]
        
        XCTAssert(action.percent == action2.percent)
    }
    
    func testStringEntryIfTextInStart() {
        let string = "o presidente Michel Temer escolheu o ministro da Defesa, Raul Jungmann, para assumir o Ministério da Segurança Pública.{0} A nova pasta deve ser criada nesta segunda-feira (26), por meio de medida provisória. Com a ida de Jungmann para o novo ministério, o general Joaquim Silva e Luna, atual secretário-executivo, deve assumir interinamente o comando do Ministério da Defesa. A escolha de Jungmann foi uma solução caseira do Palácio do Planalto. Diante da dificuldade de encontrar um nome externo, {1}o presidente Michel Temer, desde a semana passada, já amadurecia uma solução interna. Jungmann já era cotado pelo seu perfil mais político e pela experiência acumulada. Desde que assumiu a Defesa, Jungmann conduz ações constantes na segurança pública em vários estados."
        let actions = cox.findActionsInText(text: string)
        let text = actions.1!
        XCTAssert(String(text) == "o presidente Michel Temer escolheu o ministro da Defesa, Raul Jungmann, para assumir o Ministério da Segurança Pública. A nova pasta deve ser criada nesta segunda-feira (26), por meio de medida provisória. Com a ida de Jungmann para o novo ministério, o general Joaquim Silva e Luna, atual secretário-executivo, deve assumir interinamente o comando do Ministério da Defesa. A escolha de Jungmann foi uma solução caseira do Palácio do Planalto. Diante da dificuldade de encontrar um nome externo, o presidente Michel Temer, desde a semana passada, já amadurecia uma solução interna. Jungmann já era cotado pelo seu perfil mais político e pela experiência acumulada. Desde que assumiu a Defesa, Jungmann conduz ações constantes na segurança pública em vários estados.")
    }
    
    func testStringEntryIfTextInFinal() {
        let string = "o presidente Michel Temer escolheu o ministro da Defesa, Raul Jungmann, para assumir o Ministério da Segurança Pública.{0} A nova pasta deve ser criada nesta segunda-feira (26), por meio de medida provisória. Com a ida de Jungmann para o novo ministério, o general Joaquim Silva e Luna, atual secretário-executivo, deve assumir interinamente o comando do Ministério da Defesa. A escolha de Jungmann foi uma solução caseira do Palácio do Planalto. Diante da dificuldade de encontrar um nome externo, {1}o presidente Michel Temer, desde a semana passada, já amadurecia uma solução interna. Jungmann já era cotado pelo seu perfil mais político e pela experiência acumulada. Desde que assumiu a Defesa, Jungmann conduz ações constantes na segurança pública em vários estados.{2}"
        let actions = cox.findActionsInText(text: string)
        let text = actions.1!
        XCTAssert(String(text) == "o presidente Michel Temer escolheu o ministro da Defesa, Raul Jungmann, para assumir o Ministério da Segurança Pública. A nova pasta deve ser criada nesta segunda-feira (26), por meio de medida provisória. Com a ida de Jungmann para o novo ministério, o general Joaquim Silva e Luna, atual secretário-executivo, deve assumir interinamente o comando do Ministério da Defesa. A escolha de Jungmann foi uma solução caseira do Palácio do Planalto. Diante da dificuldade de encontrar um nome externo, o presidente Michel Temer, desde a semana passada, já amadurecia uma solução interna. Jungmann já era cotado pelo seu perfil mais político e pela experiência acumulada. Desde que assumiu a Defesa, Jungmann conduz ações constantes na segurança pública em vários estados.")
    }
    
    func testEntriesNameInText() {
        let string = "o presidente Michel Temer escolheu o ministro da Defesa, Raul Jungmann, para assumir o Ministério da Segurança Pública.{0} A nova pasta deve ser criada nesta segunda-feira (26), por meio de medida provisória. Com a ida de Jungmann para o novo ministério, o general Joaquim Silva e Luna, atual secretário-executivo, deve assumir interinamente o comando do Ministério da Defesa. A escolha de Jungmann foi uma solução caseira do Palácio do Planalto. Diante da dificuldade de encontrar um nome externo, {1}o presidente Michel Temer, desde a semana passada, já amadurecia uma solução interna. Jungmann já era cotado pelo seu perfil mais político e pela experiência acumulada. Desde que assumiu a Defesa, Jungmann conduz{2} ações constantes na segurança pública em vários estados."
        let actions = cox.findActionsInText(text: string)
        
        
        var names:[String] = []
        let actionsFinal = actions.0
        for action in actions.0 {
            names.append(action.name)
        }
        XCTAssert(names == ["0","1","2"])
    }
    
    func testEntriesNameInTextInStart() {
        let string = "{1}o presidente Michel Temer escolheu o ministro da Defesa, Raul Jungmann, para assumir o Ministério da Segurança Pública.{0} A nova pasta deve ser criada nesta segunda-feira (26), por meio de medida provisória. Com a ida de Jungmann para o novo ministério, o general Joaquim Silva e Luna, atual secretário-executivo, deve assumir interinamente o comando do Ministério da Defesa. A escolha de Jungmann foi uma solução caseira do Palácio do Planalto. Diante da dificuldade de encontrar um nome externo, {1}o presidente Michel Temer, desde a semana passada, já amadurecia uma solução interna. Jungmann já era cotado pelo seu perfil mais político e pela experiência acumulada. Desde que assumiu a Defesa, Jungmann conduz ações constantes na segurança pública em vários estados.{2}"
        let actions = cox.findActionsInText(text: string)
        
        
        var names:[String] = []
        for action in actions.0 {
            names.append(action.name)
        }
        XCTAssert(names == ["1","0","1","2"])
    }
    
    func testEntriesNameInTextInFinal() {
        let string = "o presidente Michel Temer escolheu o ministro da Defesa, Raul Jungmann, para assumir o Ministério da Segurança Pública.{0} A nova pasta deve ser criada nesta segunda-feira (26), por meio de medida provisória. Com a ida de Jungmann para o novo ministério, o general Joaquim Silva e Luna, atual secretário-executivo, deve assumir interinamente o comando do Ministério da Defesa. A escolha de Jungmann foi uma solução caseira do Palácio do Planalto. Diante da dificuldade de encontrar um nome externo, {1}o presidente Michel Temer, desde a semana passada, já amadurecia uma solução interna. Jungmann já era cotado pelo seu perfil mais político e pela experiência acumulada. Desde que assumiu a Defesa, Jungmann conduz ações constantes na segurança pública em vários estados.{2}"
        let actions = cox.findActionsInText(text: string)
        
        
        var names:[String] = []
        for action in actions.0 {
            names.append(action.name)
        }
        XCTAssert(names == ["0","1","2"])
    }
}
