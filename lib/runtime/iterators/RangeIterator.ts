/// <reference path="../../../typings/tsd.d.ts" />
import Iterator from "./Iterator";
import Position from "../../compiler/parsers/Position";
import * as SourceMap from "source-map";

export default class RangeIterator extends Iterator {

    private from: Iterator;
    private to: Iterator;

    constructor(position: Position, f: Iterator, to: Iterator) {
        super(position);
        this.from = f;
        this.to = to;
    }

    serialize(): SourceMap.SourceNode {
        var node = new SourceMap.SourceNode(this.position.getStartLine() + 1, this.position.getStartColumn() + 1, this.position.getFileName());
        node
            .add(this.to.serialize())
            .add(this.from.serialize())
            .add("stack.push(r.RangeIterator(stack.pop(), stack.pop()));\n");
        return node;
    }
}
