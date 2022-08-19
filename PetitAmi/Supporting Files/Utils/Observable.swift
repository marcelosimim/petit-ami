//
//  Observable.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

public class Observable<T> {
    public typealias ListenerBlock = (T) -> Void
    private var listenerBlock: ListenerBlock?
    public var isBinded: Bool { return listenerBlock != nil }

    public func bind(listenerBlock: ListenerBlock?) {
        self.listenerBlock = listenerBlock
        listenerBlock?(self.value)
    }

    public func bindWithoutFire(listenerBlock: ListenerBlock?) {
        self.listenerBlock = listenerBlock
    }

    public func unbind() {
        listenerBlock = nil
    }

    public var value: T {
        didSet {
            self.listenerBlock?(self.value)
        }
    }

    public init(_ v: T) {
        value = v
    }
}
