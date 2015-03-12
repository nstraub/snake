/**
 * Created by nico on 11/03/2015.
 */

injector.registerFake('dispatcher', function () {
    this.on = sinon.spy();
    this.off = sinon.spy();
    this.trigger = sinon.spy();
});

injector.registerFake('fake_context', function () {
    this.clearRect = sinon.spy();
    this.fillRect = sinon.spy();
    this.getImageData = sinon.stub();
});

injector.registerFake('canvas', ['fake_context', function (fake_context) {
    this.fake_context = fake_context;
    this.getContext = sinon.stub();
    this.width = 200;
    this.height = 200;
    this.getContext.withArgs('2d').returns(this.fake_context)
}]);

injector.registerType('directions', function () {
    this.up = 0;
    this.right = 1;
    this.down = 2;
    this.left = 3;
}, 'singleton');
