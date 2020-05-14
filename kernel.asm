
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 f0 2d 10 80       	mov    $0x80102df0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	c7 44 24 04 c0 6f 10 	movl   $0x80106fc0,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010005b:	e8 b0 42 00 00       	call   80104310 <initlock>
  bcache.head.next = &bcache.head;
80100060:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
  bcache.head.prev = &bcache.head;
80100065:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006f:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100076:	fc 10 80 
80100079:	eb 09                	jmp    80100084 <binit+0x44>
8010007b:	90                   	nop
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100082:	89 c3                	mov    %eax,%ebx
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 c7 6f 10 	movl   $0x80106fc7,0x4(%esp)
8010009b:	80 
8010009c:	e8 3f 41 00 00       	call   801041e0 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
    bcache.head.next = b;
801000b4:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ba:	75 c4                	jne    80100080 <binit+0x40>
  }
}
801000bc:	83 c4 14             	add    $0x14,%esp
801000bf:	5b                   	pop    %ebx
801000c0:	5d                   	pop    %ebp
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&bcache.lock);
801000dc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
{
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 95 43 00 00       	call   80104480 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000f1:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100161:	e8 8a 43 00 00       	call   801044f0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 af 40 00 00       	call   80104220 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 a2 1f 00 00       	call   80102120 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
  panic("bget: no buffers");
80100188:	c7 04 24 ce 6f 10 80 	movl   $0x80106fce,(%esp)
8010018f:	e8 cc 01 00 00       	call   80100360 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 0b 41 00 00       	call   801042c0 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
  iderw(b);
801001c4:	e9 57 1f 00 00       	jmp    80102120 <iderw>
    panic("bwrite");
801001c9:	c7 04 24 df 6f 10 80 	movl   $0x80106fdf,(%esp)
801001d0:	e8 8b 01 00 00       	call   80100360 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 ca 40 00 00       	call   801042c0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 7e 40 00 00       	call   80104280 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100209:	e8 72 42 00 00       	call   80104480 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	83 6b 4c 01          	subl   $0x1,0x4c(%ebx)
80100212:	75 2f                	jne    80100243 <brelse+0x63>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100214:	8b 43 54             	mov    0x54(%ebx),%eax
80100217:	8b 53 50             	mov    0x50(%ebx),%edx
8010021a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021d:	8b 43 50             	mov    0x50(%ebx),%eax
80100220:	8b 53 54             	mov    0x54(%ebx),%edx
80100223:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100226:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
8010022b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
80100232:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100235:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
8010023a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023d:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
80100243:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
8010024a:	83 c4 10             	add    $0x10,%esp
8010024d:	5b                   	pop    %ebx
8010024e:	5e                   	pop    %esi
8010024f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100250:	e9 9b 42 00 00       	jmp    801044f0 <release>
    panic("brelse");
80100255:	c7 04 24 e6 6f 10 80 	movl   $0x80106fe6,(%esp)
8010025c:	e8 ff 00 00 00       	call   80100360 <panic>
80100261:	66 90                	xchg   %ax,%ax
80100263:	66 90                	xchg   %ax,%ax
80100265:	66 90                	xchg   %ax,%ax
80100267:	66 90                	xchg   %ax,%ax
80100269:	66 90                	xchg   %ax,%ax
8010026b:	66 90                	xchg   %ax,%ax
8010026d:	66 90                	xchg   %ax,%ax
8010026f:	90                   	nop

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 1c             	sub    $0x1c,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	89 3c 24             	mov    %edi,(%esp)
80100282:	e8 09 15 00 00       	call   80101790 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028e:	e8 ed 41 00 00       	call   80104480 <acquire>
  while(n > 0){
80100293:	8b 55 10             	mov    0x10(%ebp),%edx
80100296:	85 d2                	test   %edx,%edx
80100298:	0f 8e bc 00 00 00    	jle    8010035a <consoleread+0xea>
8010029e:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a1:	eb 25                	jmp    801002c8 <consoleread+0x58>
801002a3:	90                   	nop
801002a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(myproc()->killed){
801002a8:	e8 43 34 00 00       	call   801036f0 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 74                	jne    80100328 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801002c3:	e8 88 3a 00 00       	call   80103d50 <sleep>
    while(input.r == input.w){
801002c8:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002cd:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	8d 50 01             	lea    0x1(%eax),%edx
801002d8:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
801002de:	89 c2                	mov    %eax,%edx
801002e0:	83 e2 7f             	and    $0x7f,%edx
801002e3:	0f b6 8a 20 ff 10 80 	movzbl -0x7fef00e0(%edx),%ecx
801002ea:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 57                	je     80100349 <consoleread+0xd9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	83 c6 01             	add    $0x1,%esi
    --n;
801002f5:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
801002f8:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
801002fb:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
801002fe:	74 53                	je     80100353 <consoleread+0xe3>
  while(n > 0){
80100300:	85 db                	test   %ebx,%ebx
80100302:	75 c4                	jne    801002c8 <consoleread+0x58>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
      break;
  }
  release(&cons.lock);
80100307:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010030e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100311:	e8 da 41 00 00       	call   801044f0 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 92 13 00 00       	call   801016b0 <ilock>
8010031e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
80100321:	eb 1e                	jmp    80100341 <consoleread+0xd1>
80100323:	90                   	nop
80100324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&cons.lock);
80100328:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010032f:	e8 bc 41 00 00       	call   801044f0 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 74 13 00 00       	call   801016b0 <ilock>
        return -1;
8010033c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100341:	83 c4 1c             	add    $0x1c,%esp
80100344:	5b                   	pop    %ebx
80100345:	5e                   	pop    %esi
80100346:	5f                   	pop    %edi
80100347:	5d                   	pop    %ebp
80100348:	c3                   	ret    
      if(n < target){
80100349:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010034c:	76 05                	jbe    80100353 <consoleread+0xe3>
        input.r--;
8010034e:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100353:	8b 45 10             	mov    0x10(%ebp),%eax
80100356:	29 d8                	sub    %ebx,%eax
80100358:	eb ad                	jmp    80100307 <consoleread+0x97>
  while(n > 0){
8010035a:	31 c0                	xor    %eax,%eax
8010035c:	eb a9                	jmp    80100307 <consoleread+0x97>
8010035e:	66 90                	xchg   %ax,%ax

80100360 <panic>:
{
80100360:	55                   	push   %ebp
80100361:	89 e5                	mov    %esp,%ebp
80100363:	56                   	push   %esi
80100364:	53                   	push   %ebx
80100365:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100368:	fa                   	cli    
  cons.locking = 0;
80100369:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100370:	00 00 00 
  getcallerpcs(&s, pcs);
80100373:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100376:	e8 e5 23 00 00       	call   80102760 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 ed 6f 10 80 	movl   $0x80106fed,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 c2 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 b7 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 ba 75 10 80 	movl   $0x801075ba,(%esp)
801003a0:	e8 ab 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 7c 3f 00 00       	call   80104330 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 01 70 10 80 	movl   $0x80107001,(%esp)
801003c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c8:	e8 83 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003cd:	39 f3                	cmp    %esi,%ebx
801003cf:	75 e7                	jne    801003b8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003d1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003d8:	00 00 00 
801003db:	eb fe                	jmp    801003db <panic+0x7b>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi

801003e0 <consputc>:
  if(panicked){
801003e0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003e6:	85 d2                	test   %edx,%edx
801003e8:	74 06                	je     801003f0 <consputc+0x10>
801003ea:	fa                   	cli    
801003eb:	eb fe                	jmp    801003eb <consputc+0xb>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	53                   	push   %ebx
801003f6:	89 c3                	mov    %eax,%ebx
801003f8:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
801003fb:	3d 00 01 00 00       	cmp    $0x100,%eax
80100400:	0f 84 ac 00 00 00    	je     801004b2 <consputc+0xd2>
    uartputc(c);
80100406:	89 04 24             	mov    %eax,(%esp)
80100409:	e8 22 57 00 00       	call   80105b30 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010040e:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100413:	b8 0e 00 00 00       	mov    $0xe,%eax
80100418:	89 fa                	mov    %edi,%edx
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	be d5 03 00 00       	mov    $0x3d5,%esi
80100420:	89 f2                	mov    %esi,%edx
80100422:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100423:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100426:	89 fa                	mov    %edi,%edx
80100428:	c1 e1 08             	shl    $0x8,%ecx
8010042b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100430:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100434:	0f b6 c0             	movzbl %al,%eax
80100437:	09 c1                	or     %eax,%ecx
  if(c == '\n')
80100439:	83 fb 0a             	cmp    $0xa,%ebx
8010043c:	0f 84 0d 01 00 00    	je     8010054f <consputc+0x16f>
  else if(c == BACKSPACE){
80100442:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100448:	0f 84 e8 00 00 00    	je     80100536 <consputc+0x156>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010044e:	0f b6 db             	movzbl %bl,%ebx
80100451:	80 cf 07             	or     $0x7,%bh
80100454:	8d 79 01             	lea    0x1(%ecx),%edi
80100457:	66 89 9c 09 00 80 0b 	mov    %bx,-0x7ff48000(%ecx,%ecx,1)
8010045e:	80 
  if(pos < 0 || pos > 25*80)
8010045f:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
80100465:	0f 87 bf 00 00 00    	ja     8010052a <consputc+0x14a>
  if((pos/80) >= 24){  // Scroll up.
8010046b:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100471:	7f 68                	jg     801004db <consputc+0xfb>
80100473:	89 f8                	mov    %edi,%eax
80100475:	89 fb                	mov    %edi,%ebx
80100477:	c1 e8 08             	shr    $0x8,%eax
8010047a:	89 c6                	mov    %eax,%esi
8010047c:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100483:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100488:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048d:	89 fa                	mov    %edi,%edx
8010048f:	ee                   	out    %al,(%dx)
80100490:	89 f0                	mov    %esi,%eax
80100492:	b2 d5                	mov    $0xd5,%dl
80100494:	ee                   	out    %al,(%dx)
80100495:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049a:	89 fa                	mov    %edi,%edx
8010049c:	ee                   	out    %al,(%dx)
8010049d:	89 d8                	mov    %ebx,%eax
8010049f:	b2 d5                	mov    $0xd5,%dl
801004a1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a2:	b8 20 07 00 00       	mov    $0x720,%eax
801004a7:	66 89 01             	mov    %ax,(%ecx)
}
801004aa:	83 c4 1c             	add    $0x1c,%esp
801004ad:	5b                   	pop    %ebx
801004ae:	5e                   	pop    %esi
801004af:	5f                   	pop    %edi
801004b0:	5d                   	pop    %ebp
801004b1:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004b2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004b9:	e8 72 56 00 00       	call   80105b30 <uartputc>
801004be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004c5:	e8 66 56 00 00       	call   80105b30 <uartputc>
801004ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004d1:	e8 5a 56 00 00       	call   80105b30 <uartputc>
801004d6:	e9 33 ff ff ff       	jmp    8010040e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004db:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004e2:	00 
    pos -= 80;
801004e3:	8d 5f b0             	lea    -0x50(%edi),%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004e6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004ed:	80 
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ee:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f5:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
801004fc:	e8 df 40 00 00       	call   801045e0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100501:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100506:	29 f8                	sub    %edi,%eax
80100508:	01 c0                	add    %eax,%eax
8010050a:	89 34 24             	mov    %esi,(%esp)
8010050d:	89 44 24 08          	mov    %eax,0x8(%esp)
80100511:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100518:	00 
80100519:	e8 22 40 00 00       	call   80104540 <memset>
8010051e:	89 f1                	mov    %esi,%ecx
80100520:	be 07 00 00 00       	mov    $0x7,%esi
80100525:	e9 59 ff ff ff       	jmp    80100483 <consputc+0xa3>
    panic("pos under/overflow");
8010052a:	c7 04 24 05 70 10 80 	movl   $0x80107005,(%esp)
80100531:	e8 2a fe ff ff       	call   80100360 <panic>
    if(pos > 0) --pos;
80100536:	85 c9                	test   %ecx,%ecx
80100538:	8d 79 ff             	lea    -0x1(%ecx),%edi
8010053b:	0f 85 1e ff ff ff    	jne    8010045f <consputc+0x7f>
80100541:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100546:	31 db                	xor    %ebx,%ebx
80100548:	31 f6                	xor    %esi,%esi
8010054a:	e9 34 ff ff ff       	jmp    80100483 <consputc+0xa3>
    pos += 80 - pos%80;
8010054f:	89 c8                	mov    %ecx,%eax
80100551:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100556:	f7 ea                	imul   %edx
80100558:	c1 ea 05             	shr    $0x5,%edx
8010055b:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010055e:	c1 e0 04             	shl    $0x4,%eax
80100561:	8d 78 50             	lea    0x50(%eax),%edi
80100564:	e9 f6 fe ff ff       	jmp    8010045f <consputc+0x7f>
80100569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	89 d6                	mov    %edx,%esi
80100577:	53                   	push   %ebx
80100578:	83 ec 1c             	sub    $0x1c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
8010057d:	74 61                	je     801005e0 <printint+0x70>
8010057f:	85 c0                	test   %eax,%eax
80100581:	79 5d                	jns    801005e0 <printint+0x70>
    x = -xx;
80100583:	f7 d8                	neg    %eax
80100585:	bf 01 00 00 00       	mov    $0x1,%edi
  i = 0;
8010058a:	31 c9                	xor    %ecx,%ecx
8010058c:	eb 04                	jmp    80100592 <printint+0x22>
8010058e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100590:	89 d9                	mov    %ebx,%ecx
80100592:	31 d2                	xor    %edx,%edx
80100594:	f7 f6                	div    %esi
80100596:	8d 59 01             	lea    0x1(%ecx),%ebx
80100599:	0f b6 92 30 70 10 80 	movzbl -0x7fef8fd0(%edx),%edx
  }while((x /= base) != 0);
801005a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005a2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005a6:	75 e8                	jne    80100590 <printint+0x20>
  if(sign)
801005a8:	85 ff                	test   %edi,%edi
    buf[i++] = digits[x % base];
801005aa:	89 d8                	mov    %ebx,%eax
  if(sign)
801005ac:	74 08                	je     801005b6 <printint+0x46>
    buf[i++] = '-';
801005ae:	8d 59 02             	lea    0x2(%ecx),%ebx
801005b1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
  while(--i >= 0)
801005b6:	83 eb 01             	sub    $0x1,%ebx
801005b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
801005c0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  while(--i >= 0)
801005c5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005c8:	e8 13 fe ff ff       	call   801003e0 <consputc>
  while(--i >= 0)
801005cd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005d0:	75 ee                	jne    801005c0 <printint+0x50>
}
801005d2:	83 c4 1c             	add    $0x1c,%esp
801005d5:	5b                   	pop    %ebx
801005d6:	5e                   	pop    %esi
801005d7:	5f                   	pop    %edi
801005d8:	5d                   	pop    %ebp
801005d9:	c3                   	ret    
801005da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    x = xx;
801005e0:	31 ff                	xor    %edi,%edi
801005e2:	eb a6                	jmp    8010058a <printint+0x1a>
801005e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 89 11 00 00       	call   80101790 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010060e:	e8 6d 3e 00 00       	call   80104480 <acquire>
80100613:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100616:	85 f6                	test   %esi,%esi
80100618:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061b:	7e 12                	jle    8010062f <consolewrite+0x3f>
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	83 c7 01             	add    $0x1,%edi
80100626:	e8 b5 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; i < n; i++)
8010062b:	39 df                	cmp    %ebx,%edi
8010062d:	75 f1                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100636:	e8 b5 3e 00 00       	call   801044f0 <release>
  ilock(ip);
8010063b:	8b 45 08             	mov    0x8(%ebp),%eax
8010063e:	89 04 24             	mov    %eax,(%esp)
80100641:	e8 6a 10 00 00       	call   801016b0 <ilock>

  return n;
}
80100646:	83 c4 1c             	add    $0x1c,%esp
80100649:	89 f0                	mov    %esi,%eax
8010064b:	5b                   	pop    %ebx
8010064c:	5e                   	pop    %esi
8010064d:	5f                   	pop    %edi
8010064e:	5d                   	pop    %ebp
8010064f:	c3                   	ret    

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100659:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100663:	0f 85 27 01 00 00    	jne    80100790 <cprintf+0x140>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 c1                	mov    %eax,%ecx
80100670:	0f 84 2b 01 00 00    	je     801007a1 <cprintf+0x151>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100676:	0f b6 00             	movzbl (%eax),%eax
80100679:	31 db                	xor    %ebx,%ebx
8010067b:	89 cf                	mov    %ecx,%edi
8010067d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100680:	85 c0                	test   %eax,%eax
80100682:	75 4c                	jne    801006d0 <cprintf+0x80>
80100684:	eb 5f                	jmp    801006e5 <cprintf+0x95>
80100686:	66 90                	xchg   %ax,%ax
    c = fmt[++i] & 0xff;
80100688:	83 c3 01             	add    $0x1,%ebx
8010068b:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
8010068f:	85 d2                	test   %edx,%edx
80100691:	74 52                	je     801006e5 <cprintf+0x95>
    switch(c){
80100693:	83 fa 70             	cmp    $0x70,%edx
80100696:	74 72                	je     8010070a <cprintf+0xba>
80100698:	7f 66                	jg     80100700 <cprintf+0xb0>
8010069a:	83 fa 25             	cmp    $0x25,%edx
8010069d:	8d 76 00             	lea    0x0(%esi),%esi
801006a0:	0f 84 a2 00 00 00    	je     80100748 <cprintf+0xf8>
801006a6:	83 fa 64             	cmp    $0x64,%edx
801006a9:	75 7d                	jne    80100728 <cprintf+0xd8>
      printint(*argp++, 10, 1);
801006ab:	8d 46 04             	lea    0x4(%esi),%eax
801006ae:	b9 01 00 00 00       	mov    $0x1,%ecx
801006b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b6:	8b 06                	mov    (%esi),%eax
801006b8:	ba 0a 00 00 00       	mov    $0xa,%edx
801006bd:	e8 ae fe ff ff       	call   80100570 <printint>
801006c2:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c5:	83 c3 01             	add    $0x1,%ebx
801006c8:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 15                	je     801006e5 <cprintf+0x95>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	74 b3                	je     80100688 <cprintf+0x38>
      consputc(c);
801006d5:	e8 06 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006da:	83 c3 01             	add    $0x1,%ebx
801006dd:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e1:	85 c0                	test   %eax,%eax
801006e3:	75 eb                	jne    801006d0 <cprintf+0x80>
  if(locking)
801006e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006e8:	85 c0                	test   %eax,%eax
801006ea:	74 0c                	je     801006f8 <cprintf+0xa8>
    release(&cons.lock);
801006ec:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006f3:	e8 f8 3d 00 00       	call   801044f0 <release>
}
801006f8:	83 c4 1c             	add    $0x1c,%esp
801006fb:	5b                   	pop    %ebx
801006fc:	5e                   	pop    %esi
801006fd:	5f                   	pop    %edi
801006fe:	5d                   	pop    %ebp
801006ff:	c3                   	ret    
    switch(c){
80100700:	83 fa 73             	cmp    $0x73,%edx
80100703:	74 53                	je     80100758 <cprintf+0x108>
80100705:	83 fa 78             	cmp    $0x78,%edx
80100708:	75 1e                	jne    80100728 <cprintf+0xd8>
      printint(*argp++, 16, 0);
8010070a:	8d 46 04             	lea    0x4(%esi),%eax
8010070d:	31 c9                	xor    %ecx,%ecx
8010070f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100712:	8b 06                	mov    (%esi),%eax
80100714:	ba 10 00 00 00       	mov    $0x10,%edx
80100719:	e8 52 fe ff ff       	call   80100570 <printint>
8010071e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100721:	eb a2                	jmp    801006c5 <cprintf+0x75>
80100723:	90                   	nop
80100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100728:	b8 25 00 00 00       	mov    $0x25,%eax
8010072d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100730:	e8 ab fc ff ff       	call   801003e0 <consputc>
      consputc(c);
80100735:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100738:	89 d0                	mov    %edx,%eax
8010073a:	e8 a1 fc ff ff       	call   801003e0 <consputc>
8010073f:	eb 99                	jmp    801006da <cprintf+0x8a>
80100741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	e8 8e fc ff ff       	call   801003e0 <consputc>
      break;
80100752:	e9 6e ff ff ff       	jmp    801006c5 <cprintf+0x75>
80100757:	90                   	nop
      if((s = (char*)*argp++) == 0)
80100758:	8d 46 04             	lea    0x4(%esi),%eax
8010075b:	8b 36                	mov    (%esi),%esi
8010075d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100760:	b8 18 70 10 80       	mov    $0x80107018,%eax
80100765:	85 f6                	test   %esi,%esi
80100767:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
8010076a:	0f be 06             	movsbl (%esi),%eax
8010076d:	84 c0                	test   %al,%al
8010076f:	74 16                	je     80100787 <cprintf+0x137>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100778:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
8010077b:	e8 60 fc ff ff       	call   801003e0 <consputc>
      for(; *s; s++)
80100780:	0f be 06             	movsbl (%esi),%eax
80100783:	84 c0                	test   %al,%al
80100785:	75 f1                	jne    80100778 <cprintf+0x128>
      if((s = (char*)*argp++) == 0)
80100787:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010078a:	e9 36 ff ff ff       	jmp    801006c5 <cprintf+0x75>
8010078f:	90                   	nop
    acquire(&cons.lock);
80100790:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100797:	e8 e4 3c 00 00       	call   80104480 <acquire>
8010079c:	e9 c8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007a1:	c7 04 24 1f 70 10 80 	movl   $0x8010701f,(%esp)
801007a8:	e8 b3 fb ff ff       	call   80100360 <panic>
801007ad:	8d 76 00             	lea    0x0(%esi),%esi

801007b0 <consoleintr>:
{
801007b0:	55                   	push   %ebp
801007b1:	89 e5                	mov    %esp,%ebp
801007b3:	57                   	push   %edi
801007b4:	56                   	push   %esi
  int c, doprocdump = 0;
801007b5:	31 f6                	xor    %esi,%esi
{
801007b7:	53                   	push   %ebx
801007b8:	83 ec 1c             	sub    $0x1c,%esp
801007bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007be:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007c5:	e8 b6 3c 00 00       	call   80104480 <acquire>
801007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801007d0:	ff d3                	call   *%ebx
801007d2:	85 c0                	test   %eax,%eax
801007d4:	89 c7                	mov    %eax,%edi
801007d6:	78 48                	js     80100820 <consoleintr+0x70>
    switch(c){
801007d8:	83 ff 10             	cmp    $0x10,%edi
801007db:	0f 84 2f 01 00 00    	je     80100910 <consoleintr+0x160>
801007e1:	7e 5d                	jle    80100840 <consoleintr+0x90>
801007e3:	83 ff 15             	cmp    $0x15,%edi
801007e6:	0f 84 d4 00 00 00    	je     801008c0 <consoleintr+0x110>
801007ec:	83 ff 7f             	cmp    $0x7f,%edi
801007ef:	90                   	nop
801007f0:	75 53                	jne    80100845 <consoleintr+0x95>
      if(input.e != input.w){
801007f2:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801007f7:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801007fd:	74 d1                	je     801007d0 <consoleintr+0x20>
        input.e--;
801007ff:	83 e8 01             	sub    $0x1,%eax
80100802:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100807:	b8 00 01 00 00       	mov    $0x100,%eax
8010080c:	e8 cf fb ff ff       	call   801003e0 <consputc>
  while((c = getc()) >= 0){
80100811:	ff d3                	call   *%ebx
80100813:	85 c0                	test   %eax,%eax
80100815:	89 c7                	mov    %eax,%edi
80100817:	79 bf                	jns    801007d8 <consoleintr+0x28>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100820:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100827:	e8 c4 3c 00 00       	call   801044f0 <release>
  if(doprocdump) {
8010082c:	85 f6                	test   %esi,%esi
8010082e:	0f 85 ec 00 00 00    	jne    80100920 <consoleintr+0x170>
}
80100834:	83 c4 1c             	add    $0x1c,%esp
80100837:	5b                   	pop    %ebx
80100838:	5e                   	pop    %esi
80100839:	5f                   	pop    %edi
8010083a:	5d                   	pop    %ebp
8010083b:	c3                   	ret    
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100840:	83 ff 08             	cmp    $0x8,%edi
80100843:	74 ad                	je     801007f2 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100845:	85 ff                	test   %edi,%edi
80100847:	74 87                	je     801007d0 <consoleintr+0x20>
80100849:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010084e:	89 c2                	mov    %eax,%edx
80100850:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100856:	83 fa 7f             	cmp    $0x7f,%edx
80100859:	0f 87 71 ff ff ff    	ja     801007d0 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
8010085f:	8d 50 01             	lea    0x1(%eax),%edx
80100862:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100865:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100868:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
8010086e:	0f 84 b8 00 00 00    	je     8010092c <consoleintr+0x17c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100874:	89 f9                	mov    %edi,%ecx
80100876:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010087c:	89 f8                	mov    %edi,%eax
8010087e:	e8 5d fb ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100883:	83 ff 04             	cmp    $0x4,%edi
80100886:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010088b:	74 19                	je     801008a6 <consoleintr+0xf6>
8010088d:	83 ff 0a             	cmp    $0xa,%edi
80100890:	74 14                	je     801008a6 <consoleintr+0xf6>
80100892:	8b 0d a0 ff 10 80    	mov    0x8010ffa0,%ecx
80100898:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
8010089e:	39 d0                	cmp    %edx,%eax
801008a0:	0f 85 2a ff ff ff    	jne    801007d0 <consoleintr+0x20>
          wakeup(&input.r);
801008a6:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
          input.w = input.e;
801008ad:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008b2:	e8 49 37 00 00       	call   80104000 <wakeup>
801008b7:	e9 14 ff ff ff       	jmp    801007d0 <consoleintr+0x20>
801008bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801008c0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008c5:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008cb:	75 2b                	jne    801008f8 <consoleintr+0x148>
801008cd:	e9 fe fe ff ff       	jmp    801007d0 <consoleintr+0x20>
801008d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
801008d8:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801008dd:	b8 00 01 00 00       	mov    $0x100,%eax
801008e2:	e8 f9 fa ff ff       	call   801003e0 <consputc>
      while(input.e != input.w &&
801008e7:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ec:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008f2:	0f 84 d8 fe ff ff    	je     801007d0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008f8:	83 e8 01             	sub    $0x1,%eax
801008fb:	89 c2                	mov    %eax,%edx
801008fd:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100900:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100907:	75 cf                	jne    801008d8 <consoleintr+0x128>
80100909:	e9 c2 fe ff ff       	jmp    801007d0 <consoleintr+0x20>
8010090e:	66 90                	xchg   %ax,%ax
      doprocdump = 1;
80100910:	be 01 00 00 00       	mov    $0x1,%esi
80100915:	e9 b6 fe ff ff       	jmp    801007d0 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100920:	83 c4 1c             	add    $0x1c,%esp
80100923:	5b                   	pop    %ebx
80100924:	5e                   	pop    %esi
80100925:	5f                   	pop    %edi
80100926:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100927:	e9 c4 37 00 00       	jmp    801040f0 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
8010092c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100933:	b8 0a 00 00 00       	mov    $0xa,%eax
80100938:	e8 a3 fa ff ff       	call   801003e0 <consputc>
8010093d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100942:	e9 5f ff ff ff       	jmp    801008a6 <consoleintr+0xf6>
80100947:	89 f6                	mov    %esi,%esi
80100949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100950 <consoleinit>:

void
consoleinit(void)
{
80100950:	55                   	push   %ebp
80100951:	89 e5                	mov    %esp,%ebp
80100953:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100956:	c7 44 24 04 28 70 10 	movl   $0x80107028,0x4(%esp)
8010095d:	80 
8010095e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100965:	e8 a6 39 00 00       	call   80104310 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
8010096a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100971:	00 
80100972:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100979:	c7 05 6c 09 11 80 f0 	movl   $0x801005f0,0x8011096c
80100980:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100983:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
8010098a:	02 10 80 
  cons.locking = 1;
8010098d:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100994:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100997:	e8 14 19 00 00       	call   801022b0 <ioapicenable>
}
8010099c:	c9                   	leave  
8010099d:	c3                   	ret    
8010099e:	66 90                	xchg   %ax,%ax

801009a0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	57                   	push   %edi
801009a4:	56                   	push   %esi
801009a5:	53                   	push   %ebx
801009a6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009ac:	e8 3f 2d 00 00       	call   801036f0 <myproc>
801009b1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009b7:	e8 54 21 00 00       	call   80102b10 <begin_op>

  if((ip = namei(path)) == 0){
801009bc:	8b 45 08             	mov    0x8(%ebp),%eax
801009bf:	89 04 24             	mov    %eax,(%esp)
801009c2:	e8 39 15 00 00       	call   80101f00 <namei>
801009c7:	85 c0                	test   %eax,%eax
801009c9:	89 c3                	mov    %eax,%ebx
801009cb:	0f 84 c2 01 00 00    	je     80100b93 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009d1:	89 04 24             	mov    %eax,(%esp)
801009d4:	e8 d7 0c 00 00       	call   801016b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801009d9:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801009df:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
801009e6:	00 
801009e7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801009ee:	00 
801009ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801009f3:	89 1c 24             	mov    %ebx,(%esp)
801009f6:	e8 65 0f 00 00       	call   80101960 <readi>
801009fb:	83 f8 34             	cmp    $0x34,%eax
801009fe:	74 20                	je     80100a20 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a00:	89 1c 24             	mov    %ebx,(%esp)
80100a03:	e8 08 0f 00 00       	call   80101910 <iunlockput>
    end_op();
80100a08:	e8 73 21 00 00       	call   80102b80 <end_op>
  }
  return -1;
80100a0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a12:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a18:	5b                   	pop    %ebx
80100a19:	5e                   	pop    %esi
80100a1a:	5f                   	pop    %edi
80100a1b:	5d                   	pop    %ebp
80100a1c:	c3                   	ret    
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80100a20:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a27:	45 4c 46 
80100a2a:	75 d4                	jne    80100a00 <exec+0x60>
  if((pgdir = setupkvm()) == 0)
80100a2c:	e8 ef 62 00 00       	call   80106d20 <setupkvm>
80100a31:	85 c0                	test   %eax,%eax
80100a33:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a39:	74 c5                	je     80100a00 <exec+0x60>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a3b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a42:	00 
80100a43:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
  sz = 0;
80100a49:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a50:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a53:	0f 84 da 00 00 00    	je     80100b33 <exec+0x193>
80100a59:	31 ff                	xor    %edi,%edi
80100a5b:	eb 18                	jmp    80100a75 <exec+0xd5>
80100a5d:	8d 76 00             	lea    0x0(%esi),%esi
80100a60:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a67:	83 c7 01             	add    $0x1,%edi
80100a6a:	83 c6 20             	add    $0x20,%esi
80100a6d:	39 f8                	cmp    %edi,%eax
80100a6f:	0f 8e be 00 00 00    	jle    80100b33 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a75:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100a7b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100a82:	00 
80100a83:	89 74 24 08          	mov    %esi,0x8(%esp)
80100a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a8b:	89 1c 24             	mov    %ebx,(%esp)
80100a8e:	e8 cd 0e 00 00       	call   80101960 <readi>
80100a93:	83 f8 20             	cmp    $0x20,%eax
80100a96:	0f 85 84 00 00 00    	jne    80100b20 <exec+0x180>
    if(ph.type != ELF_PROG_LOAD)
80100a9c:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100aa3:	75 bb                	jne    80100a60 <exec+0xc0>
    if(ph.memsz < ph.filesz)
80100aa5:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100aab:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ab1:	72 6d                	jb     80100b20 <exec+0x180>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ab3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ab9:	72 65                	jb     80100b20 <exec+0x180>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100abb:	89 44 24 08          	mov    %eax,0x8(%esp)
80100abf:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ac5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ac9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100acf:	89 04 24             	mov    %eax,(%esp)
80100ad2:	e8 b9 60 00 00       	call   80106b90 <allocuvm>
80100ad7:	85 c0                	test   %eax,%eax
80100ad9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100adf:	74 3f                	je     80100b20 <exec+0x180>
    if(ph.vaddr % PGSIZE != 0)
80100ae1:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ae7:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100aec:	75 32                	jne    80100b20 <exec+0x180>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100aee:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100af4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100af8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100afe:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b02:	89 54 24 10          	mov    %edx,0x10(%esp)
80100b06:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100b0c:	89 04 24             	mov    %eax,(%esp)
80100b0f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b13:	e8 b8 5f 00 00       	call   80106ad0 <loaduvm>
80100b18:	85 c0                	test   %eax,%eax
80100b1a:	0f 89 40 ff ff ff    	jns    80100a60 <exec+0xc0>
    freevm(pgdir);
80100b20:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b26:	89 04 24             	mov    %eax,(%esp)
80100b29:	e8 72 61 00 00       	call   80106ca0 <freevm>
80100b2e:	e9 cd fe ff ff       	jmp    80100a00 <exec+0x60>
  iunlockput(ip);
80100b33:	89 1c 24             	mov    %ebx,(%esp)
80100b36:	e8 d5 0d 00 00       	call   80101910 <iunlockput>
80100b3b:	90                   	nop
80100b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100b40:	e8 3b 20 00 00       	call   80102b80 <end_op>
  sz = PGROUNDUP(sz);
80100b45:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b4b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b50:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b55:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b5f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b65:	89 54 24 08          	mov    %edx,0x8(%esp)
80100b69:	89 04 24             	mov    %eax,(%esp)
80100b6c:	e8 1f 60 00 00       	call   80106b90 <allocuvm>
80100b71:	85 c0                	test   %eax,%eax
80100b73:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100b79:	75 33                	jne    80100bae <exec+0x20e>
    freevm(pgdir);
80100b7b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b81:	89 04 24             	mov    %eax,(%esp)
80100b84:	e8 17 61 00 00       	call   80106ca0 <freevm>
  return -1;
80100b89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b8e:	e9 7f fe ff ff       	jmp    80100a12 <exec+0x72>
    end_op();
80100b93:	e8 e8 1f 00 00       	call   80102b80 <end_op>
    cprintf("exec: fail\n");
80100b98:	c7 04 24 41 70 10 80 	movl   $0x80107041,(%esp)
80100b9f:	e8 ac fa ff ff       	call   80100650 <cprintf>
    return -1;
80100ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba9:	e9 64 fe ff ff       	jmp    80100a12 <exec+0x72>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bae:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100bb4:	89 d8                	mov    %ebx,%eax
80100bb6:	2d 00 20 00 00       	sub    $0x2000,%eax
80100bbb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bbf:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bc5:	89 04 24             	mov    %eax,(%esp)
80100bc8:	e8 03 62 00 00       	call   80106dd0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bd0:	8b 00                	mov    (%eax),%eax
80100bd2:	85 c0                	test   %eax,%eax
80100bd4:	0f 84 59 01 00 00    	je     80100d33 <exec+0x393>
80100bda:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100bdd:	31 d2                	xor    %edx,%edx
80100bdf:	8d 71 04             	lea    0x4(%ecx),%esi
80100be2:	89 cf                	mov    %ecx,%edi
80100be4:	89 d1                	mov    %edx,%ecx
80100be6:	89 f2                	mov    %esi,%edx
80100be8:	89 fe                	mov    %edi,%esi
80100bea:	89 cf                	mov    %ecx,%edi
80100bec:	eb 0a                	jmp    80100bf8 <exec+0x258>
80100bee:	66 90                	xchg   %ax,%ax
80100bf0:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100bf3:	83 ff 20             	cmp    $0x20,%edi
80100bf6:	74 83                	je     80100b7b <exec+0x1db>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bf8:	89 04 24             	mov    %eax,(%esp)
80100bfb:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100c01:	e8 5a 3b 00 00       	call   80104760 <strlen>
80100c06:	f7 d0                	not    %eax
80100c08:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0a:	8b 06                	mov    (%esi),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c0c:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0f:	89 04 24             	mov    %eax,(%esp)
80100c12:	e8 49 3b 00 00       	call   80104760 <strlen>
80100c17:	83 c0 01             	add    $0x1,%eax
80100c1a:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c1e:	8b 06                	mov    (%esi),%eax
80100c20:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c24:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c28:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c2e:	89 04 24             	mov    %eax,(%esp)
80100c31:	e8 fa 62 00 00       	call   80106f30 <copyout>
80100c36:	85 c0                	test   %eax,%eax
80100c38:	0f 88 3d ff ff ff    	js     80100b7b <exec+0x1db>
  for(argc = 0; argv[argc]; argc++) {
80100c3e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    ustack[3+argc] = sp;
80100c44:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100c4a:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c51:	83 c7 01             	add    $0x1,%edi
80100c54:	8b 02                	mov    (%edx),%eax
80100c56:	89 d6                	mov    %edx,%esi
80100c58:	85 c0                	test   %eax,%eax
80100c5a:	75 94                	jne    80100bf0 <exec+0x250>
80100c5c:	89 fa                	mov    %edi,%edx
  ustack[3+argc] = 0;
80100c5e:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100c65:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c69:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
  ustack[1] = argc;
80100c70:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c76:	89 da                	mov    %ebx,%edx
80100c78:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100c7a:	83 c0 0c             	add    $0xc,%eax
80100c7d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c7f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c83:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c89:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100c8d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[0] = 0xffffffff;  // fake return PC
80100c91:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c98:	ff ff ff 
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9b:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c9e:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ca4:	e8 87 62 00 00       	call   80106f30 <copyout>
80100ca9:	85 c0                	test   %eax,%eax
80100cab:	0f 88 ca fe ff ff    	js     80100b7b <exec+0x1db>
  for(last=s=path; *s; s++)
80100cb1:	8b 45 08             	mov    0x8(%ebp),%eax
80100cb4:	0f b6 10             	movzbl (%eax),%edx
80100cb7:	84 d2                	test   %dl,%dl
80100cb9:	74 19                	je     80100cd4 <exec+0x334>
80100cbb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cbe:	83 c0 01             	add    $0x1,%eax
      last = s+1;
80100cc1:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
80100cc4:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
80100cc7:	0f 44 c8             	cmove  %eax,%ecx
80100cca:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
80100ccd:	84 d2                	test   %dl,%dl
80100ccf:	75 f0                	jne    80100cc1 <exec+0x321>
80100cd1:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cd4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cda:	8b 45 08             	mov    0x8(%ebp),%eax
80100cdd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100ce4:	00 
80100ce5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ce9:	89 f8                	mov    %edi,%eax
80100ceb:	83 c0 6c             	add    $0x6c,%eax
80100cee:	89 04 24             	mov    %eax,(%esp)
80100cf1:	e8 2a 3a 00 00       	call   80104720 <safestrcpy>
  curproc->pgdir = pgdir;
80100cf6:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100cfc:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->tf->eip = elf.entry;  // main
80100cff:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100d02:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100d05:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100d0b:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100d0d:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d13:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d16:	8b 47 18             	mov    0x18(%edi),%eax
80100d19:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d1c:	89 3c 24             	mov    %edi,(%esp)
80100d1f:	e8 1c 5c 00 00       	call   80106940 <switchuvm>
  freevm(oldpgdir);
80100d24:	89 34 24             	mov    %esi,(%esp)
80100d27:	e8 74 5f 00 00       	call   80106ca0 <freevm>
  return 0;
80100d2c:	31 c0                	xor    %eax,%eax
80100d2e:	e9 df fc ff ff       	jmp    80100a12 <exec+0x72>
  for(argc = 0; argv[argc]; argc++) {
80100d33:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100d39:	31 d2                	xor    %edx,%edx
80100d3b:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d41:	e9 18 ff ff ff       	jmp    80100c5e <exec+0x2be>
80100d46:	66 90                	xchg   %ax,%ax
80100d48:	66 90                	xchg   %ax,%ax
80100d4a:	66 90                	xchg   %ax,%ax
80100d4c:	66 90                	xchg   %ax,%ax
80100d4e:	66 90                	xchg   %ax,%ax

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	c7 44 24 04 4d 70 10 	movl   $0x8010704d,0x4(%esp)
80100d5d:	80 
80100d5e:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d65:	e8 a6 35 00 00       	call   80104310 <initlock>
}
80100d6a:	c9                   	leave  
80100d6b:	c3                   	ret    
80100d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100d79:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d7c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d83:	e8 f8 36 00 00       	call   80104480 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da2:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
      f->ref = 1;
80100da9:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100db0:	e8 3b 37 00 00       	call   801044f0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100db5:	83 c4 14             	add    $0x14,%esp
      return f;
80100db8:	89 d8                	mov    %ebx,%eax
}
80100dba:	5b                   	pop    %ebx
80100dbb:	5d                   	pop    %ebp
80100dbc:	c3                   	ret    
80100dbd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100dc0:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100dc7:	e8 24 37 00 00       	call   801044f0 <release>
}
80100dcc:	83 c4 14             	add    $0x14,%esp
  return 0;
80100dcf:	31 c0                	xor    %eax,%eax
}
80100dd1:	5b                   	pop    %ebx
80100dd2:	5d                   	pop    %ebp
80100dd3:	c3                   	ret    
80100dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 14             	sub    $0x14,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100df1:	e8 8a 36 00 00       	call   80104480 <acquire>
  if(f->ref < 1)
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 1a                	jle    80100e17 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100dfd:	83 c0 01             	add    $0x1,%eax
80100e00:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e03:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e0a:	e8 e1 36 00 00       	call   801044f0 <release>
  return f;
}
80100e0f:	83 c4 14             	add    $0x14,%esp
80100e12:	89 d8                	mov    %ebx,%eax
80100e14:	5b                   	pop    %ebx
80100e15:	5d                   	pop    %ebp
80100e16:	c3                   	ret    
    panic("filedup");
80100e17:	c7 04 24 54 70 10 80 	movl   $0x80107054,(%esp)
80100e1e:	e8 3d f5 ff ff       	call   80100360 <panic>
80100e23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 1c             	sub    $0x1c,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e43:	e8 38 36 00 00       	call   80104480 <acquire>
  if(f->ref < 1)
80100e48:	8b 57 04             	mov    0x4(%edi),%edx
80100e4b:	85 d2                	test   %edx,%edx
80100e4d:	0f 8e 89 00 00 00    	jle    80100edc <fileclose+0xac>
    panic("fileclose");
  if(--f->ref > 0){
80100e53:	83 ea 01             	sub    $0x1,%edx
80100e56:	85 d2                	test   %edx,%edx
80100e58:	89 57 04             	mov    %edx,0x4(%edi)
80100e5b:	74 13                	je     80100e70 <fileclose+0x40>
    release(&ftable.lock);
80100e5d:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e64:	83 c4 1c             	add    $0x1c,%esp
80100e67:	5b                   	pop    %ebx
80100e68:	5e                   	pop    %esi
80100e69:	5f                   	pop    %edi
80100e6a:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e6b:	e9 80 36 00 00       	jmp    801044f0 <release>
  ff = *f;
80100e70:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e74:	8b 37                	mov    (%edi),%esi
80100e76:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->type = FD_NONE;
80100e79:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  ff = *f;
80100e7f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e82:	8b 47 10             	mov    0x10(%edi),%eax
  release(&ftable.lock);
80100e85:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
  ff = *f;
80100e8c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e8f:	e8 5c 36 00 00       	call   801044f0 <release>
  if(ff.type == FD_PIPE)
80100e94:	83 fe 01             	cmp    $0x1,%esi
80100e97:	74 0f                	je     80100ea8 <fileclose+0x78>
  else if(ff.type == FD_INODE){
80100e99:	83 fe 02             	cmp    $0x2,%esi
80100e9c:	74 22                	je     80100ec0 <fileclose+0x90>
}
80100e9e:	83 c4 1c             	add    $0x1c,%esp
80100ea1:	5b                   	pop    %ebx
80100ea2:	5e                   	pop    %esi
80100ea3:	5f                   	pop    %edi
80100ea4:	5d                   	pop    %ebp
80100ea5:	c3                   	ret    
80100ea6:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100ea8:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100eac:	89 1c 24             	mov    %ebx,(%esp)
80100eaf:	89 74 24 04          	mov    %esi,0x4(%esp)
80100eb3:	e8 a8 23 00 00       	call   80103260 <pipeclose>
80100eb8:	eb e4                	jmp    80100e9e <fileclose+0x6e>
80100eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    begin_op();
80100ec0:	e8 4b 1c 00 00       	call   80102b10 <begin_op>
    iput(ff.ip);
80100ec5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ec8:	89 04 24             	mov    %eax,(%esp)
80100ecb:	e8 00 09 00 00       	call   801017d0 <iput>
}
80100ed0:	83 c4 1c             	add    $0x1c,%esp
80100ed3:	5b                   	pop    %ebx
80100ed4:	5e                   	pop    %esi
80100ed5:	5f                   	pop    %edi
80100ed6:	5d                   	pop    %ebp
    end_op();
80100ed7:	e9 a4 1c 00 00       	jmp    80102b80 <end_op>
    panic("fileclose");
80100edc:	c7 04 24 5c 70 10 80 	movl   $0x8010705c,(%esp)
80100ee3:	e8 78 f4 ff ff       	call   80100360 <panic>
80100ee8:	90                   	nop
80100ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 14             	sub    $0x14,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100efa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100efd:	75 31                	jne    80100f30 <filestat+0x40>
    ilock(f->ip);
80100eff:	8b 43 10             	mov    0x10(%ebx),%eax
80100f02:	89 04 24             	mov    %eax,(%esp)
80100f05:	e8 a6 07 00 00       	call   801016b0 <ilock>
    stati(f->ip, st);
80100f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f11:	8b 43 10             	mov    0x10(%ebx),%eax
80100f14:	89 04 24             	mov    %eax,(%esp)
80100f17:	e8 14 0a 00 00       	call   80101930 <stati>
    iunlock(f->ip);
80100f1c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f1f:	89 04 24             	mov    %eax,(%esp)
80100f22:	e8 69 08 00 00       	call   80101790 <iunlock>
    return 0;
  }
  return -1;
}
80100f27:	83 c4 14             	add    $0x14,%esp
    return 0;
80100f2a:	31 c0                	xor    %eax,%eax
}
80100f2c:	5b                   	pop    %ebx
80100f2d:	5d                   	pop    %ebp
80100f2e:	c3                   	ret    
80100f2f:	90                   	nop
80100f30:	83 c4 14             	add    $0x14,%esp
  return -1;
80100f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f38:	5b                   	pop    %ebx
80100f39:	5d                   	pop    %ebp
80100f3a:	c3                   	ret    
80100f3b:	90                   	nop
80100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 1c             	sub    $0x1c,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f4f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f56:	74 68                	je     80100fc0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80100f58:	8b 03                	mov    (%ebx),%eax
80100f5a:	83 f8 01             	cmp    $0x1,%eax
80100f5d:	74 49                	je     80100fa8 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f5f:	83 f8 02             	cmp    $0x2,%eax
80100f62:	75 63                	jne    80100fc7 <fileread+0x87>
    ilock(f->ip);
80100f64:	8b 43 10             	mov    0x10(%ebx),%eax
80100f67:	89 04 24             	mov    %eax,(%esp)
80100f6a:	e8 41 07 00 00       	call   801016b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f6f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f73:	8b 43 14             	mov    0x14(%ebx),%eax
80100f76:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f7a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f7e:	8b 43 10             	mov    0x10(%ebx),%eax
80100f81:	89 04 24             	mov    %eax,(%esp)
80100f84:	e8 d7 09 00 00       	call   80101960 <readi>
80100f89:	85 c0                	test   %eax,%eax
80100f8b:	89 c6                	mov    %eax,%esi
80100f8d:	7e 03                	jle    80100f92 <fileread+0x52>
      f->off += r;
80100f8f:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f92:	8b 43 10             	mov    0x10(%ebx),%eax
80100f95:	89 04 24             	mov    %eax,(%esp)
80100f98:	e8 f3 07 00 00       	call   80101790 <iunlock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f9d:	89 f0                	mov    %esi,%eax
    return r;
  }
  panic("fileread");
}
80100f9f:	83 c4 1c             	add    $0x1c,%esp
80100fa2:	5b                   	pop    %ebx
80100fa3:	5e                   	pop    %esi
80100fa4:	5f                   	pop    %edi
80100fa5:	5d                   	pop    %ebp
80100fa6:	c3                   	ret    
80100fa7:	90                   	nop
    return piperead(f->pipe, addr, n);
80100fa8:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fab:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fae:	83 c4 1c             	add    $0x1c,%esp
80100fb1:	5b                   	pop    %ebx
80100fb2:	5e                   	pop    %esi
80100fb3:	5f                   	pop    %edi
80100fb4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fb5:	e9 26 24 00 00       	jmp    801033e0 <piperead>
80100fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fc5:	eb d8                	jmp    80100f9f <fileread+0x5f>
  panic("fileread");
80100fc7:	c7 04 24 66 70 10 80 	movl   $0x80107066,(%esp)
80100fce:	e8 8d f3 ff ff       	call   80100360 <panic>
80100fd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fe0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 2c             	sub    $0x2c,%esp
80100fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fec:	8b 7d 08             	mov    0x8(%ebp),%edi
80100fef:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80100ff5:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80100ffc:	0f 84 ae 00 00 00    	je     801010b0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101002:	8b 07                	mov    (%edi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d7 00 00 00    	jne    801010ed <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 db                	xor    %ebx,%ebx
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 31                	jg     80101050 <filewrite+0x70>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101028:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
8010102b:	01 47 14             	add    %eax,0x14(%edi)
8010102e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101031:	89 0c 24             	mov    %ecx,(%esp)
80101034:	e8 57 07 00 00       	call   80101790 <iunlock>
      end_op();
80101039:	e8 42 1b 00 00       	call   80102b80 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101041:	39 f0                	cmp    %esi,%eax
80101043:	0f 85 98 00 00 00    	jne    801010e1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101049:	01 c3                	add    %eax,%ebx
    while(i < n){
8010104b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010104e:	7e 70                	jle    801010c0 <filewrite+0xe0>
      int n1 = n - i;
80101050:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101053:	b8 00 06 00 00       	mov    $0x600,%eax
80101058:	29 de                	sub    %ebx,%esi
8010105a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101060:	0f 4f f0             	cmovg  %eax,%esi
      begin_op();
80101063:	e8 a8 1a 00 00       	call   80102b10 <begin_op>
      ilock(f->ip);
80101068:	8b 47 10             	mov    0x10(%edi),%eax
8010106b:	89 04 24             	mov    %eax,(%esp)
8010106e:	e8 3d 06 00 00       	call   801016b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101073:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101077:	8b 47 14             	mov    0x14(%edi),%eax
8010107a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010107e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101081:	01 d8                	add    %ebx,%eax
80101083:	89 44 24 04          	mov    %eax,0x4(%esp)
80101087:	8b 47 10             	mov    0x10(%edi),%eax
8010108a:	89 04 24             	mov    %eax,(%esp)
8010108d:	e8 ce 09 00 00       	call   80101a60 <writei>
80101092:	85 c0                	test   %eax,%eax
80101094:	7f 92                	jg     80101028 <filewrite+0x48>
      iunlock(f->ip);
80101096:	8b 4f 10             	mov    0x10(%edi),%ecx
80101099:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010109c:	89 0c 24             	mov    %ecx,(%esp)
8010109f:	e8 ec 06 00 00       	call   80101790 <iunlock>
      end_op();
801010a4:	e8 d7 1a 00 00       	call   80102b80 <end_op>
      if(r < 0)
801010a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ac:	85 c0                	test   %eax,%eax
801010ae:	74 91                	je     80101041 <filewrite+0x61>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010b0:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801010b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010b8:	5b                   	pop    %ebx
801010b9:	5e                   	pop    %esi
801010ba:	5f                   	pop    %edi
801010bb:	5d                   	pop    %ebp
801010bc:	c3                   	ret    
801010bd:	8d 76 00             	lea    0x0(%esi),%esi
    return i == n ? n : -1;
801010c0:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
801010c3:	89 d8                	mov    %ebx,%eax
801010c5:	75 e9                	jne    801010b0 <filewrite+0xd0>
}
801010c7:	83 c4 2c             	add    $0x2c,%esp
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801010cf:	8b 47 0c             	mov    0xc(%edi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010d5:	83 c4 2c             	add    $0x2c,%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010dc:	e9 0f 22 00 00       	jmp    801032f0 <pipewrite>
        panic("short filewrite");
801010e1:	c7 04 24 6f 70 10 80 	movl   $0x8010706f,(%esp)
801010e8:	e8 73 f2 ff ff       	call   80100360 <panic>
  panic("filewrite");
801010ed:	c7 04 24 75 70 10 80 	movl   $0x80107075,(%esp)
801010f4:	e8 67 f2 ff ff       	call   80100360 <panic>
801010f9:	66 90                	xchg   %ax,%ax
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	89 d7                	mov    %edx,%edi
80101106:	56                   	push   %esi
80101107:	53                   	push   %ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101108:	bb 01 00 00 00       	mov    $0x1,%ebx
{
8010110d:	83 ec 1c             	sub    $0x1c,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101110:	c1 ea 0c             	shr    $0xc,%edx
80101113:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101119:	89 04 24             	mov    %eax,(%esp)
8010111c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101120:	e8 ab ef ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101125:	89 f9                	mov    %edi,%ecx
  bi = b % BPB;
80101127:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
8010112d:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
8010112f:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101132:	c1 fa 03             	sar    $0x3,%edx
  m = 1 << (bi % 8);
80101135:	d3 e3                	shl    %cl,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101137:	89 c6                	mov    %eax,%esi
  if((bp->data[bi/8] & m) == 0)
80101139:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
8010113e:	0f b6 c8             	movzbl %al,%ecx
80101141:	85 d9                	test   %ebx,%ecx
80101143:	74 20                	je     80101165 <bfree+0x65>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101145:	f7 d3                	not    %ebx
80101147:	21 c3                	and    %eax,%ebx
80101149:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
8010114d:	89 34 24             	mov    %esi,(%esp)
80101150:	e8 5b 1b 00 00       	call   80102cb0 <log_write>
  brelse(bp);
80101155:	89 34 24             	mov    %esi,(%esp)
80101158:	e8 83 f0 ff ff       	call   801001e0 <brelse>
}
8010115d:	83 c4 1c             	add    $0x1c,%esp
80101160:	5b                   	pop    %ebx
80101161:	5e                   	pop    %esi
80101162:	5f                   	pop    %edi
80101163:	5d                   	pop    %ebp
80101164:	c3                   	ret    
    panic("freeing free block");
80101165:	c7 04 24 7f 70 10 80 	movl   $0x8010707f,(%esp)
8010116c:	e8 ef f1 ff ff       	call   80100360 <panic>
80101171:	eb 0d                	jmp    80101180 <balloc>
80101173:	90                   	nop
80101174:	90                   	nop
80101175:	90                   	nop
80101176:	90                   	nop
80101177:	90                   	nop
80101178:	90                   	nop
80101179:	90                   	nop
8010117a:	90                   	nop
8010117b:	90                   	nop
8010117c:	90                   	nop
8010117d:	90                   	nop
8010117e:	90                   	nop
8010117f:	90                   	nop

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 2c             	sub    $0x2c,%esp
80101189:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010118c:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101191:	85 c0                	test   %eax,%eax
80101193:	0f 84 8c 00 00 00    	je     80101225 <balloc+0xa5>
80101199:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a0:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a3:	89 f0                	mov    %esi,%eax
801011a5:	c1 f8 0c             	sar    $0xc,%eax
801011a8:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801011b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011b5:	89 04 24             	mov    %eax,(%esp)
801011b8:	e8 13 ef ff ff       	call   801000d0 <bread>
801011bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801011c0:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011c8:	31 c0                	xor    %eax,%eax
801011ca:	eb 33                	jmp    801011ff <balloc+0x7f>
801011cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011d3:	89 c2                	mov    %eax,%edx
      m = 1 << (bi % 8);
801011d5:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d7:	c1 fa 03             	sar    $0x3,%edx
      m = 1 << (bi % 8);
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	bf 01 00 00 00       	mov    $0x1,%edi
801011e2:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011e4:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx
      m = 1 << (bi % 8);
801011e9:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011eb:	0f b6 fb             	movzbl %bl,%edi
801011ee:	85 cf                	test   %ecx,%edi
801011f0:	74 46                	je     80101238 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011f2:	83 c0 01             	add    $0x1,%eax
801011f5:	83 c6 01             	add    $0x1,%esi
801011f8:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fd:	74 05                	je     80101204 <balloc+0x84>
801011ff:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101202:	72 cc                	jb     801011d0 <balloc+0x50>
    brelse(bp);
80101204:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101207:	89 04 24             	mov    %eax,(%esp)
8010120a:	e8 d1 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120f:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	3b 05 c0 09 11 80    	cmp    0x801109c0,%eax
8010121f:	0f 82 7b ff ff ff    	jb     801011a0 <balloc+0x20>
  panic("balloc: out of blocks");
80101225:	c7 04 24 92 70 10 80 	movl   $0x80107092,(%esp)
8010122c:	e8 2f f1 ff ff       	call   80100360 <panic>
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101238:	09 d9                	or     %ebx,%ecx
8010123a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010123d:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
80101241:	89 1c 24             	mov    %ebx,(%esp)
80101244:	e8 67 1a 00 00       	call   80102cb0 <log_write>
        brelse(bp);
80101249:	89 1c 24             	mov    %ebx,(%esp)
8010124c:	e8 8f ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
80101251:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101254:	89 74 24 04          	mov    %esi,0x4(%esp)
80101258:	89 04 24             	mov    %eax,(%esp)
8010125b:	e8 70 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101260:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101267:	00 
80101268:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010126f:	00 
  bp = bread(dev, bno);
80101270:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101272:	8d 40 5c             	lea    0x5c(%eax),%eax
80101275:	89 04 24             	mov    %eax,(%esp)
80101278:	e8 c3 32 00 00       	call   80104540 <memset>
  log_write(bp);
8010127d:	89 1c 24             	mov    %ebx,(%esp)
80101280:	e8 2b 1a 00 00       	call   80102cb0 <log_write>
  brelse(bp);
80101285:	89 1c 24             	mov    %ebx,(%esp)
80101288:	e8 53 ef ff ff       	call   801001e0 <brelse>
}
8010128d:	83 c4 2c             	add    $0x2c,%esp
80101290:	89 f0                	mov    %esi,%eax
80101292:	5b                   	pop    %ebx
80101293:	5e                   	pop    %esi
80101294:	5f                   	pop    %edi
80101295:	5d                   	pop    %ebp
80101296:	c3                   	ret    
80101297:	89 f6                	mov    %esi,%esi
80101299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	89 c7                	mov    %eax,%edi
801012a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012a7:	31 f6                	xor    %esi,%esi
{
801012a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012aa:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012af:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&icache.lock);
801012b2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
{
801012b9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012bc:	e8 bf 31 00 00       	call   80104480 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012c4:	eb 14                	jmp    801012da <iget+0x3a>
801012c6:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012c8:	85 f6                	test   %esi,%esi
801012ca:	74 3c                	je     80101308 <iget+0x68>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012cc:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012d2:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012d8:	74 46                	je     80101320 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012da:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	7e e7                	jle    801012c8 <iget+0x28>
801012e1:	39 3b                	cmp    %edi,(%ebx)
801012e3:	75 e3                	jne    801012c8 <iget+0x28>
801012e5:	39 53 04             	cmp    %edx,0x4(%ebx)
801012e8:	75 de                	jne    801012c8 <iget+0x28>
      ip->ref++;
801012ea:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012ed:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012ef:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
      ip->ref++;
801012f6:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012f9:	e8 f2 31 00 00       	call   801044f0 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801012fe:	83 c4 1c             	add    $0x1c,%esp
80101301:	89 f0                	mov    %esi,%eax
80101303:	5b                   	pop    %ebx
80101304:	5e                   	pop    %esi
80101305:	5f                   	pop    %edi
80101306:	5d                   	pop    %ebp
80101307:	c3                   	ret    
80101308:	85 c9                	test   %ecx,%ecx
8010130a:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101313:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101319:	75 bf                	jne    801012da <iget+0x3a>
8010131b:	90                   	nop
8010131c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(empty == 0)
80101320:	85 f6                	test   %esi,%esi
80101322:	74 29                	je     8010134d <iget+0xad>
  ip->dev = dev;
80101324:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101326:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101329:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101330:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101337:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010133e:	e8 ad 31 00 00       	call   801044f0 <release>
}
80101343:	83 c4 1c             	add    $0x1c,%esp
80101346:	89 f0                	mov    %esi,%eax
80101348:	5b                   	pop    %ebx
80101349:	5e                   	pop    %esi
8010134a:	5f                   	pop    %edi
8010134b:	5d                   	pop    %ebp
8010134c:	c3                   	ret    
    panic("iget: no inodes");
8010134d:	c7 04 24 a8 70 10 80 	movl   $0x801070a8,(%esp)
80101354:	e8 07 f0 ff ff       	call   80100360 <panic>
80101359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c3                	mov    %eax,%ebx
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0b             	cmp    $0xb,%edx
8010136e:	77 18                	ja     80101388 <bmap+0x28>
80101370:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 46 5c             	mov    0x5c(%esi),%eax
80101376:	85 c0                	test   %eax,%eax
80101378:	74 66                	je     801013e0 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	83 c4 1c             	add    $0x1c,%esp
8010137d:	5b                   	pop    %ebx
8010137e:	5e                   	pop    %esi
8010137f:	5f                   	pop    %edi
80101380:	5d                   	pop    %ebp
80101381:	c3                   	ret    
80101382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;
80101388:	8d 72 f4             	lea    -0xc(%edx),%esi
  if(bn < NINDIRECT){
8010138b:	83 fe 7f             	cmp    $0x7f,%esi
8010138e:	77 77                	ja     80101407 <bmap+0xa7>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101390:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101396:	85 c0                	test   %eax,%eax
80101398:	74 5e                	je     801013f8 <bmap+0x98>
    bp = bread(ip->dev, addr);
8010139a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010139e:	8b 03                	mov    (%ebx),%eax
801013a0:	89 04 24             	mov    %eax,(%esp)
801013a3:	e8 28 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013a8:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx
    bp = bread(ip->dev, addr);
801013ac:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013ae:	8b 32                	mov    (%edx),%esi
801013b0:	85 f6                	test   %esi,%esi
801013b2:	75 19                	jne    801013cd <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
801013b4:	8b 03                	mov    (%ebx),%eax
801013b6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013b9:	e8 c2 fd ff ff       	call   80101180 <balloc>
801013be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013c1:	89 02                	mov    %eax,(%edx)
801013c3:	89 c6                	mov    %eax,%esi
      log_write(bp);
801013c5:	89 3c 24             	mov    %edi,(%esp)
801013c8:	e8 e3 18 00 00       	call   80102cb0 <log_write>
    brelse(bp);
801013cd:	89 3c 24             	mov    %edi,(%esp)
801013d0:	e8 0b ee ff ff       	call   801001e0 <brelse>
}
801013d5:	83 c4 1c             	add    $0x1c,%esp
    brelse(bp);
801013d8:	89 f0                	mov    %esi,%eax
}
801013da:	5b                   	pop    %ebx
801013db:	5e                   	pop    %esi
801013dc:	5f                   	pop    %edi
801013dd:	5d                   	pop    %ebp
801013de:	c3                   	ret    
801013df:	90                   	nop
      ip->addrs[bn] = addr = balloc(ip->dev);
801013e0:	8b 03                	mov    (%ebx),%eax
801013e2:	e8 99 fd ff ff       	call   80101180 <balloc>
801013e7:	89 46 5c             	mov    %eax,0x5c(%esi)
}
801013ea:	83 c4 1c             	add    $0x1c,%esp
801013ed:	5b                   	pop    %ebx
801013ee:	5e                   	pop    %esi
801013ef:	5f                   	pop    %edi
801013f0:	5d                   	pop    %ebp
801013f1:	c3                   	ret    
801013f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013f8:	8b 03                	mov    (%ebx),%eax
801013fa:	e8 81 fd ff ff       	call   80101180 <balloc>
801013ff:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101405:	eb 93                	jmp    8010139a <bmap+0x3a>
  panic("bmap: out of range");
80101407:	c7 04 24 b8 70 10 80 	movl   $0x801070b8,(%esp)
8010140e:	e8 4d ef ff ff       	call   80100360 <panic>
80101413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101420 <readsb>:
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	53                   	push   %ebx
80101425:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, 1);
80101428:	8b 45 08             	mov    0x8(%ebp),%eax
8010142b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101432:	00 
{
80101433:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101436:	89 04 24             	mov    %eax,(%esp)
80101439:	e8 92 ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010143e:	89 34 24             	mov    %esi,(%esp)
80101441:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101448:	00 
  bp = bread(dev, 1);
80101449:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010144b:	8d 40 5c             	lea    0x5c(%eax),%eax
8010144e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101452:	e8 89 31 00 00       	call   801045e0 <memmove>
  brelse(bp);
80101457:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010145a:	83 c4 10             	add    $0x10,%esp
8010145d:	5b                   	pop    %ebx
8010145e:	5e                   	pop    %esi
8010145f:	5d                   	pop    %ebp
  brelse(bp);
80101460:	e9 7b ed ff ff       	jmp    801001e0 <brelse>
80101465:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101470 <iinit>:
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101479:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
8010147c:	c7 44 24 04 cb 70 10 	movl   $0x801070cb,0x4(%esp)
80101483:	80 
80101484:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010148b:	e8 80 2e 00 00       	call   80104310 <initlock>
    initsleeplock(&icache.inode[i].lock, "inode");
80101490:	89 1c 24             	mov    %ebx,(%esp)
80101493:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101499:	c7 44 24 04 d2 70 10 	movl   $0x801070d2,0x4(%esp)
801014a0:	80 
801014a1:	e8 3a 2d 00 00       	call   801041e0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014a6:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014ac:	75 e2                	jne    80101490 <iinit+0x20>
  readsb(dev, &sb);
801014ae:	8b 45 08             	mov    0x8(%ebp),%eax
801014b1:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801014b8:	80 
801014b9:	89 04 24             	mov    %eax,(%esp)
801014bc:	e8 5f ff ff ff       	call   80101420 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014c1:	a1 d8 09 11 80       	mov    0x801109d8,%eax
801014c6:	c7 04 24 38 71 10 80 	movl   $0x80107138,(%esp)
801014cd:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801014d1:	a1 d4 09 11 80       	mov    0x801109d4,%eax
801014d6:	89 44 24 18          	mov    %eax,0x18(%esp)
801014da:	a1 d0 09 11 80       	mov    0x801109d0,%eax
801014df:	89 44 24 14          	mov    %eax,0x14(%esp)
801014e3:	a1 cc 09 11 80       	mov    0x801109cc,%eax
801014e8:	89 44 24 10          	mov    %eax,0x10(%esp)
801014ec:	a1 c8 09 11 80       	mov    0x801109c8,%eax
801014f1:	89 44 24 0c          	mov    %eax,0xc(%esp)
801014f5:	a1 c4 09 11 80       	mov    0x801109c4,%eax
801014fa:	89 44 24 08          	mov    %eax,0x8(%esp)
801014fe:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101503:	89 44 24 04          	mov    %eax,0x4(%esp)
80101507:	e8 44 f1 ff ff       	call   80100650 <cprintf>
}
8010150c:	83 c4 24             	add    $0x24,%esp
8010150f:	5b                   	pop    %ebx
80101510:	5d                   	pop    %ebp
80101511:	c3                   	ret    
80101512:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 2c             	sub    $0x2c,%esp
80101529:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010152c:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101533:	8b 7d 08             	mov    0x8(%ebp),%edi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 a2 00 00 00    	jbe    801015e1 <ialloc+0xc1>
8010153f:	be 01 00 00 00       	mov    $0x1,%esi
80101544:	bb 01 00 00 00       	mov    $0x1,%ebx
80101549:	eb 1a                	jmp    80101565 <ialloc+0x45>
8010154b:	90                   	nop
8010154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
80101550:	89 14 24             	mov    %edx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	e8 85 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155b:	89 de                	mov    %ebx,%esi
8010155d:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101563:	73 7c                	jae    801015e1 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
80101565:	89 f0                	mov    %esi,%eax
80101567:	c1 e8 03             	shr    $0x3,%eax
8010156a:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101570:	89 3c 24             	mov    %edi,(%esp)
80101573:	89 44 24 04          	mov    %eax,0x4(%esp)
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 f0                	mov    %esi,%eax
80101580:	83 e0 07             	and    $0x7,%eax
80101583:	c1 e0 06             	shl    $0x6,%eax
80101586:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158a:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010158e:	75 c0                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101590:	89 0c 24             	mov    %ecx,(%esp)
80101593:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010159a:	00 
8010159b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801015a2:	00 
801015a3:	89 55 dc             	mov    %edx,-0x24(%ebp)
801015a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015a9:	e8 92 2f 00 00       	call   80104540 <memset>
      dip->type = type;
801015ae:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
801015b2:	8b 55 dc             	mov    -0x24(%ebp),%edx
      dip->type = type;
801015b5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
801015b8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      dip->type = type;
801015bb:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015be:	89 14 24             	mov    %edx,(%esp)
801015c1:	e8 ea 16 00 00       	call   80102cb0 <log_write>
      brelse(bp);
801015c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015c9:	89 14 24             	mov    %edx,(%esp)
801015cc:	e8 0f ec ff ff       	call   801001e0 <brelse>
}
801015d1:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
801015d4:	89 f2                	mov    %esi,%edx
}
801015d6:	5b                   	pop    %ebx
      return iget(dev, inum);
801015d7:	89 f8                	mov    %edi,%eax
}
801015d9:	5e                   	pop    %esi
801015da:	5f                   	pop    %edi
801015db:	5d                   	pop    %ebp
      return iget(dev, inum);
801015dc:	e9 bf fc ff ff       	jmp    801012a0 <iget>
  panic("ialloc: no inodes");
801015e1:	c7 04 24 d8 70 10 80 	movl   $0x801070d8,(%esp)
801015e8:	e8 73 ed ff ff       	call   80100360 <panic>
801015ed:	8d 76 00             	lea    0x0(%esi),%esi

801015f0 <iupdate>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	56                   	push   %esi
801015f4:	53                   	push   %ebx
801015f5:	83 ec 10             	sub    $0x10,%esp
801015f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015fb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fe:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101601:	c1 e8 03             	shr    $0x3,%eax
80101604:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010160a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010160e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101611:	89 04 24             	mov    %eax,(%esp)
80101614:	e8 b7 ea ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101619:	8b 53 a8             	mov    -0x58(%ebx),%edx
8010161c:	83 e2 07             	and    $0x7,%edx
8010161f:	c1 e2 06             	shl    $0x6,%edx
80101622:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101626:	89 c6                	mov    %eax,%esi
  dip->type = ip->type;
80101628:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162c:	83 c2 0c             	add    $0xc,%edx
  dip->type = ip->type;
8010162f:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
80101633:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
80101637:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
8010163b:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
8010163f:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
80101643:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
80101647:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
8010164b:	8b 43 fc             	mov    -0x4(%ebx),%eax
8010164e:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101651:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101655:	89 14 24             	mov    %edx,(%esp)
80101658:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010165f:	00 
80101660:	e8 7b 2f 00 00       	call   801045e0 <memmove>
  log_write(bp);
80101665:	89 34 24             	mov    %esi,(%esp)
80101668:	e8 43 16 00 00       	call   80102cb0 <log_write>
  brelse(bp);
8010166d:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101670:	83 c4 10             	add    $0x10,%esp
80101673:	5b                   	pop    %ebx
80101674:	5e                   	pop    %esi
80101675:	5d                   	pop    %ebp
  brelse(bp);
80101676:	e9 65 eb ff ff       	jmp    801001e0 <brelse>
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <idup>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	53                   	push   %ebx
80101684:	83 ec 14             	sub    $0x14,%esp
80101687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010168a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101691:	e8 ea 2d 00 00       	call   80104480 <acquire>
  ip->ref++;
80101696:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010169a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016a1:	e8 4a 2e 00 00       	call   801044f0 <release>
}
801016a6:	83 c4 14             	add    $0x14,%esp
801016a9:	89 d8                	mov    %ebx,%eax
801016ab:	5b                   	pop    %ebx
801016ac:	5d                   	pop    %ebp
801016ad:	c3                   	ret    
801016ae:	66 90                	xchg   %ax,%ax

801016b0 <ilock>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	83 ec 10             	sub    $0x10,%esp
801016b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016bb:	85 db                	test   %ebx,%ebx
801016bd:	0f 84 b3 00 00 00    	je     80101776 <ilock+0xc6>
801016c3:	8b 53 08             	mov    0x8(%ebx),%edx
801016c6:	85 d2                	test   %edx,%edx
801016c8:	0f 8e a8 00 00 00    	jle    80101776 <ilock+0xc6>
  acquiresleep(&ip->lock);
801016ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801016d1:	89 04 24             	mov    %eax,(%esp)
801016d4:	e8 47 2b 00 00       	call   80104220 <acquiresleep>
  if(ip->valid == 0){
801016d9:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016dc:	85 c0                	test   %eax,%eax
801016de:	74 08                	je     801016e8 <ilock+0x38>
}
801016e0:	83 c4 10             	add    $0x10,%esp
801016e3:	5b                   	pop    %ebx
801016e4:	5e                   	pop    %esi
801016e5:	5d                   	pop    %ebp
801016e6:	c3                   	ret    
801016e7:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e8:	8b 43 04             	mov    0x4(%ebx),%eax
801016eb:	c1 e8 03             	shr    $0x3,%eax
801016ee:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016f4:	89 44 24 04          	mov    %eax,0x4(%esp)
801016f8:	8b 03                	mov    (%ebx),%eax
801016fa:	89 04 24             	mov    %eax,(%esp)
801016fd:	e8 ce e9 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101702:	8b 53 04             	mov    0x4(%ebx),%edx
80101705:	83 e2 07             	and    $0x7,%edx
80101708:	c1 e2 06             	shl    $0x6,%edx
8010170b:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010170f:	89 c6                	mov    %eax,%esi
    ip->type = dip->type;
80101711:	0f b7 02             	movzwl (%edx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101714:	83 c2 0c             	add    $0xc,%edx
    ip->type = dip->type;
80101717:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010171b:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
8010171f:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101723:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
80101727:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
8010172b:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
8010172f:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
80101733:	8b 42 fc             	mov    -0x4(%edx),%eax
80101736:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101739:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010173c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101740:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101747:	00 
80101748:	89 04 24             	mov    %eax,(%esp)
8010174b:	e8 90 2e 00 00       	call   801045e0 <memmove>
    brelse(bp);
80101750:	89 34 24             	mov    %esi,(%esp)
80101753:	e8 88 ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101758:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010175d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101764:	0f 85 76 ff ff ff    	jne    801016e0 <ilock+0x30>
      panic("ilock: no type");
8010176a:	c7 04 24 f0 70 10 80 	movl   $0x801070f0,(%esp)
80101771:	e8 ea eb ff ff       	call   80100360 <panic>
    panic("ilock");
80101776:	c7 04 24 ea 70 10 80 	movl   $0x801070ea,(%esp)
8010177d:	e8 de eb ff ff       	call   80100360 <panic>
80101782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101790 <iunlock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	83 ec 10             	sub    $0x10,%esp
80101798:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010179b:	85 db                	test   %ebx,%ebx
8010179d:	74 24                	je     801017c3 <iunlock+0x33>
8010179f:	8d 73 0c             	lea    0xc(%ebx),%esi
801017a2:	89 34 24             	mov    %esi,(%esp)
801017a5:	e8 16 2b 00 00       	call   801042c0 <holdingsleep>
801017aa:	85 c0                	test   %eax,%eax
801017ac:	74 15                	je     801017c3 <iunlock+0x33>
801017ae:	8b 43 08             	mov    0x8(%ebx),%eax
801017b1:	85 c0                	test   %eax,%eax
801017b3:	7e 0e                	jle    801017c3 <iunlock+0x33>
  releasesleep(&ip->lock);
801017b5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	5b                   	pop    %ebx
801017bc:	5e                   	pop    %esi
801017bd:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017be:	e9 bd 2a 00 00       	jmp    80104280 <releasesleep>
    panic("iunlock");
801017c3:	c7 04 24 ff 70 10 80 	movl   $0x801070ff,(%esp)
801017ca:	e8 91 eb ff ff       	call   80100360 <panic>
801017cf:	90                   	nop

801017d0 <iput>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	53                   	push   %ebx
801017d6:	83 ec 1c             	sub    $0x1c,%esp
801017d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801017dc:	8d 7e 0c             	lea    0xc(%esi),%edi
801017df:	89 3c 24             	mov    %edi,(%esp)
801017e2:	e8 39 2a 00 00       	call   80104220 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017e7:	8b 56 4c             	mov    0x4c(%esi),%edx
801017ea:	85 d2                	test   %edx,%edx
801017ec:	74 07                	je     801017f5 <iput+0x25>
801017ee:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017f3:	74 2b                	je     80101820 <iput+0x50>
  releasesleep(&ip->lock);
801017f5:	89 3c 24             	mov    %edi,(%esp)
801017f8:	e8 83 2a 00 00       	call   80104280 <releasesleep>
  acquire(&icache.lock);
801017fd:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101804:	e8 77 2c 00 00       	call   80104480 <acquire>
  ip->ref--;
80101809:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010180d:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101814:	83 c4 1c             	add    $0x1c,%esp
80101817:	5b                   	pop    %ebx
80101818:	5e                   	pop    %esi
80101819:	5f                   	pop    %edi
8010181a:	5d                   	pop    %ebp
  release(&icache.lock);
8010181b:	e9 d0 2c 00 00       	jmp    801044f0 <release>
    acquire(&icache.lock);
80101820:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101827:	e8 54 2c 00 00       	call   80104480 <acquire>
    int r = ip->ref;
8010182c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010182f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101836:	e8 b5 2c 00 00       	call   801044f0 <release>
    if(r == 1){
8010183b:	83 fb 01             	cmp    $0x1,%ebx
8010183e:	75 b5                	jne    801017f5 <iput+0x25>
80101840:	8d 4e 30             	lea    0x30(%esi),%ecx
80101843:	89 f3                	mov    %esi,%ebx
80101845:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x87>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fb                	cmp    %edi,%ebx
80101855:	74 19                	je     80101870 <iput+0xa0>
    if(ip->addrs[i]){
80101857:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010185a:	85 d2                	test   %edx,%edx
8010185c:	74 f2                	je     80101850 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
8010185e:	8b 06                	mov    (%esi),%eax
80101860:	e8 9b f8 ff ff       	call   80101100 <bfree>
      ip->addrs[i] = 0;
80101865:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
8010186c:	eb e2                	jmp    80101850 <iput+0x80>
8010186e:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 2b                	jne    801018a8 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010187d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101884:	89 34 24             	mov    %esi,(%esp)
80101887:	e8 64 fd ff ff       	call   801015f0 <iupdate>
      ip->type = 0;
8010188c:	31 c0                	xor    %eax,%eax
8010188e:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101892:	89 34 24             	mov    %esi,(%esp)
80101895:	e8 56 fd ff ff       	call   801015f0 <iupdate>
      ip->valid = 0;
8010189a:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018a1:	e9 4f ff ff ff       	jmp    801017f5 <iput+0x25>
801018a6:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801018ac:	8b 06                	mov    (%esi),%eax
    for(j = 0; j < NINDIRECT; j++){
801018ae:	31 db                	xor    %ebx,%ebx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	89 04 24             	mov    %eax,(%esp)
801018b3:	e8 18 e8 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801018b8:	89 7d e0             	mov    %edi,-0x20(%ebp)
    a = (uint*)bp->data;
801018bb:	8d 48 5c             	lea    0x5c(%eax),%ecx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801018c1:	89 cf                	mov    %ecx,%edi
801018c3:	31 c0                	xor    %eax,%eax
801018c5:	eb 0e                	jmp    801018d5 <iput+0x105>
801018c7:	90                   	nop
801018c8:	83 c3 01             	add    $0x1,%ebx
801018cb:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
801018d1:	89 d8                	mov    %ebx,%eax
801018d3:	74 10                	je     801018e5 <iput+0x115>
      if(a[j])
801018d5:	8b 14 87             	mov    (%edi,%eax,4),%edx
801018d8:	85 d2                	test   %edx,%edx
801018da:	74 ec                	je     801018c8 <iput+0xf8>
        bfree(ip->dev, a[j]);
801018dc:	8b 06                	mov    (%esi),%eax
801018de:	e8 1d f8 ff ff       	call   80101100 <bfree>
801018e3:	eb e3                	jmp    801018c8 <iput+0xf8>
    brelse(bp);
801018e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801018e8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018eb:	89 04 24             	mov    %eax,(%esp)
801018ee:	e8 ed e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018f3:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018f9:	8b 06                	mov    (%esi),%eax
801018fb:	e8 00 f8 ff ff       	call   80101100 <bfree>
    ip->addrs[NDIRECT] = 0;
80101900:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101907:	00 00 00 
8010190a:	e9 6e ff ff ff       	jmp    8010187d <iput+0xad>
8010190f:	90                   	nop

80101910 <iunlockput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 14             	sub    $0x14,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	89 1c 24             	mov    %ebx,(%esp)
8010191d:	e8 6e fe ff ff       	call   80101790 <iunlock>
  iput(ip);
80101922:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101925:	83 c4 14             	add    $0x14,%esp
80101928:	5b                   	pop    %ebx
80101929:	5d                   	pop    %ebp
  iput(ip);
8010192a:	e9 a1 fe ff ff       	jmp    801017d0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 2c             	sub    $0x2c,%esp
80101969:	8b 45 0c             	mov    0xc(%ebp),%eax
8010196c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010196f:	8b 75 10             	mov    0x10(%ebp),%esi
80101972:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101975:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101978:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
8010197d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101980:	0f 84 aa 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101986:	8b 47 58             	mov    0x58(%edi),%eax
80101989:	39 f0                	cmp    %esi,%eax
8010198b:	0f 82 c7 00 00 00    	jb     80101a58 <readi+0xf8>
80101991:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101994:	89 da                	mov    %ebx,%edx
80101996:	01 f2                	add    %esi,%edx
80101998:	0f 82 ba 00 00 00    	jb     80101a58 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010199e:	89 c1                	mov    %eax,%ecx
801019a0:	29 f1                	sub    %esi,%ecx
801019a2:	39 d0                	cmp    %edx,%eax
801019a4:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019a7:	31 c0                	xor    %eax,%eax
801019a9:	85 c9                	test   %ecx,%ecx
    n = ip->size - off;
801019ab:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ae:	74 70                	je     80101a20 <readi+0xc0>
801019b0:	89 7d d8             	mov    %edi,-0x28(%ebp)
801019b3:	89 c7                	mov    %eax,%edi
801019b5:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019b8:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019bb:	89 f2                	mov    %esi,%edx
801019bd:	c1 ea 09             	shr    $0x9,%edx
801019c0:	89 d8                	mov    %ebx,%eax
801019c2:	e8 99 f9 ff ff       	call   80101360 <bmap>
801019c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801019cb:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019cd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d2:	89 04 24             	mov    %eax,(%esp)
801019d5:	e8 f6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801019dd:	29 f9                	sub    %edi,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019df:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019e1:	89 f0                	mov    %esi,%eax
801019e3:	25 ff 01 00 00       	and    $0x1ff,%eax
801019e8:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019ea:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019ee:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801019f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019f7:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fa:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019fe:	01 df                	add    %ebx,%edi
80101a00:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a02:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101a05:	89 04 24             	mov    %eax,(%esp)
80101a08:	e8 d3 2b 00 00       	call   801045e0 <memmove>
    brelse(bp);
80101a0d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a10:	89 14 24             	mov    %edx,(%esp)
80101a13:	e8 c8 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a18:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a1e:	77 98                	ja     801019b8 <readi+0x58>
  }
  return n;
80101a20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a23:	83 c4 2c             	add    $0x2c,%esp
80101a26:	5b                   	pop    %ebx
80101a27:	5e                   	pop    %esi
80101a28:	5f                   	pop    %edi
80101a29:	5d                   	pop    %ebp
80101a2a:	c3                   	ret    
80101a2b:	90                   	nop
80101a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 1e                	ja     80101a58 <readi+0xf8>
80101a3a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 13                	je     80101a58 <readi+0xf8>
    return devsw[ip->major].read(ip, dst, n);
80101a45:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101a48:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101a4b:	83 c4 2c             	add    $0x2c,%esp
80101a4e:	5b                   	pop    %ebx
80101a4f:	5e                   	pop    %esi
80101a50:	5f                   	pop    %edi
80101a51:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a52:	ff e0                	jmp    *%eax
80101a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a5d:	eb c4                	jmp    80101a23 <readi+0xc3>
80101a5f:	90                   	nop

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 2c             	sub    $0x2c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	8b 75 10             	mov    0x10(%ebp),%esi
80101a7d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a80:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 e3 00 00 00    	jb     80101b78 <writei+0x118>
80101a95:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a98:	89 c8                	mov    %ecx,%eax
80101a9a:	01 f0                	add    %esi,%eax
80101a9c:	0f 82 d6 00 00 00    	jb     80101b78 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101aa2:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa7:	0f 87 cb 00 00 00    	ja     80101b78 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101aad:	85 c9                	test   %ecx,%ecx
80101aaf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ab6:	74 77                	je     80101b2f <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab8:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101abb:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101abd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac2:	c1 ea 09             	shr    $0x9,%edx
80101ac5:	89 f8                	mov    %edi,%eax
80101ac7:	e8 94 f8 ff ff       	call   80101360 <bmap>
80101acc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ad0:	8b 07                	mov    (%edi),%eax
80101ad2:	89 04 24             	mov    %eax,(%esp)
80101ad5:	e8 f6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101ada:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101add:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ae0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae3:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae5:	89 f0                	mov    %esi,%eax
80101ae7:	25 ff 01 00 00       	and    $0x1ff,%eax
80101aec:	29 c3                	sub    %eax,%ebx
80101aee:	39 cb                	cmp    %ecx,%ebx
80101af0:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af7:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101af9:	89 54 24 04          	mov    %edx,0x4(%esp)
80101afd:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b01:	89 04 24             	mov    %eax,(%esp)
80101b04:	e8 d7 2a 00 00       	call   801045e0 <memmove>
    log_write(bp);
80101b09:	89 3c 24             	mov    %edi,(%esp)
80101b0c:	e8 9f 11 00 00       	call   80102cb0 <log_write>
    brelse(bp);
80101b11:	89 3c 24             	mov    %edi,(%esp)
80101b14:	e8 c7 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b19:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b1f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b22:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b25:	77 91                	ja     80101ab8 <writei+0x58>
  }

  if(n > 0 && off > ip->size){
80101b27:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2a:	39 70 58             	cmp    %esi,0x58(%eax)
80101b2d:	72 39                	jb     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b32:	83 c4 2c             	add    $0x2c,%esp
80101b35:	5b                   	pop    %ebx
80101b36:	5e                   	pop    %esi
80101b37:	5f                   	pop    %edi
80101b38:	5d                   	pop    %ebp
80101b39:	c3                   	ret    
80101b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 2e                	ja     80101b78 <writei+0x118>
80101b4a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 23                	je     80101b78 <writei+0x118>
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 4d 10             	mov    %ecx,0x10(%ebp)
}
80101b58:	83 c4 2c             	add    $0x2c,%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b6e:	89 04 24             	mov    %eax,(%esp)
80101b71:	e8 7a fa ff ff       	call   801015f0 <iupdate>
80101b76:	eb b7                	jmp    80101b2f <writei+0xcf>
}
80101b78:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80101b7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101b80:	5b                   	pop    %ebx
80101b81:	5e                   	pop    %esi
80101b82:	5f                   	pop    %edi
80101b83:	5d                   	pop    %ebp
80101b84:	c3                   	ret    
80101b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b99:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101ba0:	00 
80101ba1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba8:	89 04 24             	mov    %eax,(%esp)
80101bab:	e8 b0 2a 00 00       	call   80104660 <strncmp>
}
80101bb0:	c9                   	leave  
80101bb1:	c3                   	ret    
80101bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 2c             	sub    $0x2c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 97 00 00 00    	jne    80101c6e <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	75 0d                	jne    80101bf0 <dirlookup+0x30>
80101be3:	eb 73                	jmp    80101c58 <dirlookup+0x98>
80101be5:	8d 76 00             	lea    0x0(%esi),%esi
80101be8:	83 c7 10             	add    $0x10,%edi
80101beb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bee:	76 68                	jbe    80101c58 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bf0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101bf7:	00 
80101bf8:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101bfc:	89 74 24 04          	mov    %esi,0x4(%esp)
80101c00:	89 1c 24             	mov    %ebx,(%esp)
80101c03:	e8 58 fd ff ff       	call   80101960 <readi>
80101c08:	83 f8 10             	cmp    $0x10,%eax
80101c0b:	75 55                	jne    80101c62 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101c0d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c12:	74 d4                	je     80101be8 <dirlookup+0x28>
  return strncmp(s, t, DIRSIZ);
80101c14:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c17:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c1e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101c25:	00 
80101c26:	89 04 24             	mov    %eax,(%esp)
80101c29:	e8 32 2a 00 00       	call   80104660 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c2e:	85 c0                	test   %eax,%eax
80101c30:	75 b6                	jne    80101be8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c32:	8b 45 10             	mov    0x10(%ebp),%eax
80101c35:	85 c0                	test   %eax,%eax
80101c37:	74 05                	je     80101c3e <dirlookup+0x7e>
        *poff = off;
80101c39:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c42:	8b 03                	mov    (%ebx),%eax
80101c44:	e8 57 f6 ff ff       	call   801012a0 <iget>
    }
  }

  return 0;
}
80101c49:	83 c4 2c             	add    $0x2c,%esp
80101c4c:	5b                   	pop    %ebx
80101c4d:	5e                   	pop    %esi
80101c4e:	5f                   	pop    %edi
80101c4f:	5d                   	pop    %ebp
80101c50:	c3                   	ret    
80101c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c58:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101c5b:	31 c0                	xor    %eax,%eax
}
80101c5d:	5b                   	pop    %ebx
80101c5e:	5e                   	pop    %esi
80101c5f:	5f                   	pop    %edi
80101c60:	5d                   	pop    %ebp
80101c61:	c3                   	ret    
      panic("dirlookup read");
80101c62:	c7 04 24 19 71 10 80 	movl   $0x80107119,(%esp)
80101c69:	e8 f2 e6 ff ff       	call   80100360 <panic>
    panic("dirlookup not DIR");
80101c6e:	c7 04 24 07 71 10 80 	movl   $0x80107107,(%esp)
80101c75:	e8 e6 e6 ff ff       	call   80100360 <panic>
80101c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	89 cf                	mov    %ecx,%edi
80101c86:	56                   	push   %esi
80101c87:	53                   	push   %ebx
80101c88:	89 c3                	mov    %eax,%ebx
80101c8a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c8d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c93:	0f 84 51 01 00 00    	je     80101dea <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c99:	e8 52 1a 00 00       	call   801036f0 <myproc>
80101c9e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ca1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101ca8:	e8 d3 27 00 00       	call   80104480 <acquire>
  ip->ref++;
80101cad:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cb1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cb8:	e8 33 28 00 00       	call   801044f0 <release>
80101cbd:	eb 04                	jmp    80101cc3 <namex+0x43>
80101cbf:	90                   	nop
    path++;
80101cc0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cc3:	0f b6 03             	movzbl (%ebx),%eax
80101cc6:	3c 2f                	cmp    $0x2f,%al
80101cc8:	74 f6                	je     80101cc0 <namex+0x40>
  if(*path == 0)
80101cca:	84 c0                	test   %al,%al
80101ccc:	0f 84 ed 00 00 00    	je     80101dbf <namex+0x13f>
  while(*path != '/' && *path != 0)
80101cd2:	0f b6 03             	movzbl (%ebx),%eax
80101cd5:	89 da                	mov    %ebx,%edx
80101cd7:	84 c0                	test   %al,%al
80101cd9:	0f 84 b1 00 00 00    	je     80101d90 <namex+0x110>
80101cdf:	3c 2f                	cmp    $0x2f,%al
80101ce1:	75 0f                	jne    80101cf2 <namex+0x72>
80101ce3:	e9 a8 00 00 00       	jmp    80101d90 <namex+0x110>
80101ce8:	3c 2f                	cmp    $0x2f,%al
80101cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101cf0:	74 0a                	je     80101cfc <namex+0x7c>
    path++;
80101cf2:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cf5:	0f b6 02             	movzbl (%edx),%eax
80101cf8:	84 c0                	test   %al,%al
80101cfa:	75 ec                	jne    80101ce8 <namex+0x68>
80101cfc:	89 d1                	mov    %edx,%ecx
80101cfe:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d00:	83 f9 0d             	cmp    $0xd,%ecx
80101d03:	0f 8e 8f 00 00 00    	jle    80101d98 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d09:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101d0d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d14:	00 
80101d15:	89 3c 24             	mov    %edi,(%esp)
80101d18:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d1b:	e8 c0 28 00 00       	call   801045e0 <memmove>
    path++;
80101d20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d23:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d25:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d28:	75 0e                	jne    80101d38 <namex+0xb8>
80101d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101d30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d36:	74 f8                	je     80101d30 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d38:	89 34 24             	mov    %esi,(%esp)
80101d3b:	e8 70 f9 ff ff       	call   801016b0 <ilock>
    if(ip->type != T_DIR){
80101d40:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d45:	0f 85 85 00 00 00    	jne    80101dd0 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d4b:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d4e:	85 d2                	test   %edx,%edx
80101d50:	74 09                	je     80101d5b <namex+0xdb>
80101d52:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d55:	0f 84 a5 00 00 00    	je     80101e00 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d5b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101d62:	00 
80101d63:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101d67:	89 34 24             	mov    %esi,(%esp)
80101d6a:	e8 51 fe ff ff       	call   80101bc0 <dirlookup>
80101d6f:	85 c0                	test   %eax,%eax
80101d71:	74 5d                	je     80101dd0 <namex+0x150>
  iunlock(ip);
80101d73:	89 34 24             	mov    %esi,(%esp)
80101d76:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d79:	e8 12 fa ff ff       	call   80101790 <iunlock>
  iput(ip);
80101d7e:	89 34 24             	mov    %esi,(%esp)
80101d81:	e8 4a fa ff ff       	call   801017d0 <iput>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101d86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d89:	89 c6                	mov    %eax,%esi
80101d8b:	e9 33 ff ff ff       	jmp    80101cc3 <namex+0x43>
  while(*path != '/' && *path != 0)
80101d90:	31 c9                	xor    %ecx,%ecx
80101d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(name, s, len);
80101d98:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101d9c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101da0:	89 3c 24             	mov    %edi,(%esp)
80101da3:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da9:	e8 32 28 00 00       	call   801045e0 <memmove>
    name[len] = 0;
80101dae:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101db1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101db4:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101db8:	89 d3                	mov    %edx,%ebx
80101dba:	e9 66 ff ff ff       	jmp    80101d25 <namex+0xa5>
  }
  if(nameiparent){
80101dbf:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dc2:	85 c0                	test   %eax,%eax
80101dc4:	75 4c                	jne    80101e12 <namex+0x192>
80101dc6:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101dc8:	83 c4 2c             	add    $0x2c,%esp
80101dcb:	5b                   	pop    %ebx
80101dcc:	5e                   	pop    %esi
80101dcd:	5f                   	pop    %edi
80101dce:	5d                   	pop    %ebp
80101dcf:	c3                   	ret    
  iunlock(ip);
80101dd0:	89 34 24             	mov    %esi,(%esp)
80101dd3:	e8 b8 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101dd8:	89 34 24             	mov    %esi,(%esp)
80101ddb:	e8 f0 f9 ff ff       	call   801017d0 <iput>
}
80101de0:	83 c4 2c             	add    $0x2c,%esp
      return 0;
80101de3:	31 c0                	xor    %eax,%eax
}
80101de5:	5b                   	pop    %ebx
80101de6:	5e                   	pop    %esi
80101de7:	5f                   	pop    %edi
80101de8:	5d                   	pop    %ebp
80101de9:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101dea:	ba 01 00 00 00       	mov    $0x1,%edx
80101def:	b8 01 00 00 00       	mov    $0x1,%eax
80101df4:	e8 a7 f4 ff ff       	call   801012a0 <iget>
80101df9:	89 c6                	mov    %eax,%esi
80101dfb:	e9 c3 fe ff ff       	jmp    80101cc3 <namex+0x43>
      iunlock(ip);
80101e00:	89 34 24             	mov    %esi,(%esp)
80101e03:	e8 88 f9 ff ff       	call   80101790 <iunlock>
}
80101e08:	83 c4 2c             	add    $0x2c,%esp
      return ip;
80101e0b:	89 f0                	mov    %esi,%eax
}
80101e0d:	5b                   	pop    %ebx
80101e0e:	5e                   	pop    %esi
80101e0f:	5f                   	pop    %edi
80101e10:	5d                   	pop    %ebp
80101e11:	c3                   	ret    
    iput(ip);
80101e12:	89 34 24             	mov    %esi,(%esp)
80101e15:	e8 b6 f9 ff ff       	call   801017d0 <iput>
    return 0;
80101e1a:	31 c0                	xor    %eax,%eax
80101e1c:	eb aa                	jmp    80101dc8 <namex+0x148>
80101e1e:	66 90                	xchg   %ax,%ax

80101e20 <dirlink>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 2c             	sub    $0x2c,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e2f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e36:	00 
80101e37:	89 1c 24             	mov    %ebx,(%esp)
80101e3a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e3e:	e8 7d fd ff ff       	call   80101bc0 <dirlookup>
80101e43:	85 c0                	test   %eax,%eax
80101e45:	0f 85 8b 00 00 00    	jne    80101ed6 <dirlink+0xb6>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e4b:	8b 43 58             	mov    0x58(%ebx),%eax
80101e4e:	31 ff                	xor    %edi,%edi
80101e50:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e53:	85 c0                	test   %eax,%eax
80101e55:	75 13                	jne    80101e6a <dirlink+0x4a>
80101e57:	eb 35                	jmp    80101e8e <dirlink+0x6e>
80101e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e60:	8d 57 10             	lea    0x10(%edi),%edx
80101e63:	39 53 58             	cmp    %edx,0x58(%ebx)
80101e66:	89 d7                	mov    %edx,%edi
80101e68:	76 24                	jbe    80101e8e <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e6a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101e71:	00 
80101e72:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101e76:	89 74 24 04          	mov    %esi,0x4(%esp)
80101e7a:	89 1c 24             	mov    %ebx,(%esp)
80101e7d:	e8 de fa ff ff       	call   80101960 <readi>
80101e82:	83 f8 10             	cmp    $0x10,%eax
80101e85:	75 5e                	jne    80101ee5 <dirlink+0xc5>
    if(de.inum == 0)
80101e87:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8c:	75 d2                	jne    80101e60 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e91:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101e98:	00 
80101e99:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e9d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ea0:	89 04 24             	mov    %eax,(%esp)
80101ea3:	e8 28 28 00 00       	call   801046d0 <strncpy>
  de.inum = inum;
80101ea8:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eab:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101eb2:	00 
80101eb3:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101eb7:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ebb:	89 1c 24             	mov    %ebx,(%esp)
  de.inum = inum;
80101ebe:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ec2:	e8 99 fb ff ff       	call   80101a60 <writei>
80101ec7:	83 f8 10             	cmp    $0x10,%eax
80101eca:	75 25                	jne    80101ef1 <dirlink+0xd1>
  return 0;
80101ecc:	31 c0                	xor    %eax,%eax
}
80101ece:	83 c4 2c             	add    $0x2c,%esp
80101ed1:	5b                   	pop    %ebx
80101ed2:	5e                   	pop    %esi
80101ed3:	5f                   	pop    %edi
80101ed4:	5d                   	pop    %ebp
80101ed5:	c3                   	ret    
    iput(ip);
80101ed6:	89 04 24             	mov    %eax,(%esp)
80101ed9:	e8 f2 f8 ff ff       	call   801017d0 <iput>
    return -1;
80101ede:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ee3:	eb e9                	jmp    80101ece <dirlink+0xae>
      panic("dirlink read");
80101ee5:	c7 04 24 28 71 10 80 	movl   $0x80107128,(%esp)
80101eec:	e8 6f e4 ff ff       	call   80100360 <panic>
    panic("dirlink");
80101ef1:	c7 04 24 8a 77 10 80 	movl   $0x8010778a,(%esp)
80101ef8:	e8 63 e4 ff ff       	call   80100360 <panic>
80101efd:	8d 76 00             	lea    0x0(%esi),%esi

80101f00 <namei>:

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 6d fd ff ff       	call   80101c80 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f2f:	e9 4c fd ff ff       	jmp    80101c80 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	56                   	push   %esi
80101f44:	89 c6                	mov    %eax,%esi
80101f46:	53                   	push   %ebx
80101f47:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101f4a:	85 c0                	test   %eax,%eax
80101f4c:	0f 84 99 00 00 00    	je     80101feb <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f52:	8b 48 08             	mov    0x8(%eax),%ecx
80101f55:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101f5b:	0f 87 7e 00 00 00    	ja     80101fdf <idestart+0x9f>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f61:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f66:	66 90                	xchg   %ax,%ax
80101f68:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f69:	83 e0 c0             	and    $0xffffffc0,%eax
80101f6c:	3c 40                	cmp    $0x40,%al
80101f6e:	75 f8                	jne    80101f68 <idestart+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f70:	31 db                	xor    %ebx,%ebx
80101f72:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f77:	89 d8                	mov    %ebx,%eax
80101f79:	ee                   	out    %al,(%dx)
80101f7a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f7f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f84:	ee                   	out    %al,(%dx)
80101f85:	0f b6 c1             	movzbl %cl,%eax
80101f88:	b2 f3                	mov    $0xf3,%dl
80101f8a:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f8b:	89 c8                	mov    %ecx,%eax
80101f8d:	b2 f4                	mov    $0xf4,%dl
80101f8f:	c1 f8 08             	sar    $0x8,%eax
80101f92:	ee                   	out    %al,(%dx)
80101f93:	b2 f5                	mov    $0xf5,%dl
80101f95:	89 d8                	mov    %ebx,%eax
80101f97:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f98:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f9c:	b2 f6                	mov    $0xf6,%dl
80101f9e:	83 e0 01             	and    $0x1,%eax
80101fa1:	c1 e0 04             	shl    $0x4,%eax
80101fa4:	83 c8 e0             	or     $0xffffffe0,%eax
80101fa7:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fa8:	f6 06 04             	testb  $0x4,(%esi)
80101fab:	75 13                	jne    80101fc0 <idestart+0x80>
80101fad:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fb2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fb7:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fb8:	83 c4 10             	add    $0x10,%esp
80101fbb:	5b                   	pop    %ebx
80101fbc:	5e                   	pop    %esi
80101fbd:	5d                   	pop    %ebp
80101fbe:	c3                   	ret    
80101fbf:	90                   	nop
80101fc0:	b2 f7                	mov    $0xf7,%dl
80101fc2:	b8 30 00 00 00       	mov    $0x30,%eax
80101fc7:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fc8:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fcd:	83 c6 5c             	add    $0x5c,%esi
80101fd0:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fd5:	fc                   	cld    
80101fd6:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fd8:	83 c4 10             	add    $0x10,%esp
80101fdb:	5b                   	pop    %ebx
80101fdc:	5e                   	pop    %esi
80101fdd:	5d                   	pop    %ebp
80101fde:	c3                   	ret    
    panic("incorrect blockno");
80101fdf:	c7 04 24 94 71 10 80 	movl   $0x80107194,(%esp)
80101fe6:	e8 75 e3 ff ff       	call   80100360 <panic>
    panic("idestart");
80101feb:	c7 04 24 8b 71 10 80 	movl   $0x8010718b,(%esp)
80101ff2:	e8 69 e3 ff ff       	call   80100360 <panic>
80101ff7:	89 f6                	mov    %esi,%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102000 <ideinit>:
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
80102006:	c7 44 24 04 a6 71 10 	movl   $0x801071a6,0x4(%esp)
8010200d:	80 
8010200e:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102015:	e8 f6 22 00 00       	call   80104310 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010201a:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010201f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102026:	83 e8 01             	sub    $0x1,%eax
80102029:	89 44 24 04          	mov    %eax,0x4(%esp)
8010202d:	e8 7e 02 00 00       	call   801022b0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102032:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102037:	90                   	nop
80102038:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102039:	83 e0 c0             	and    $0xffffffc0,%eax
8010203c:	3c 40                	cmp    $0x40,%al
8010203e:	75 f8                	jne    80102038 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102040:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102045:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010204a:	ee                   	out    %al,(%dx)
8010204b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102050:	b2 f7                	mov    $0xf7,%dl
80102052:	eb 09                	jmp    8010205d <ideinit+0x5d>
80102054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102058:	83 e9 01             	sub    $0x1,%ecx
8010205b:	74 0f                	je     8010206c <ideinit+0x6c>
8010205d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010205e:	84 c0                	test   %al,%al
80102060:	74 f6                	je     80102058 <ideinit+0x58>
      havedisk1 = 1;
80102062:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102069:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010206c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102071:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102076:	ee                   	out    %al,(%dx)
}
80102077:	c9                   	leave  
80102078:	c3                   	ret    
80102079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102089:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102090:	e8 eb 23 00 00       	call   80104480 <acquire>

  if((b = idequeue) == 0){
80102095:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
8010209b:	85 db                	test   %ebx,%ebx
8010209d:	74 30                	je     801020cf <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010209f:	8b 43 58             	mov    0x58(%ebx),%eax
801020a2:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020a7:	8b 33                	mov    (%ebx),%esi
801020a9:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020af:	74 37                	je     801020e8 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020b1:	83 e6 fb             	and    $0xfffffffb,%esi
801020b4:	83 ce 02             	or     $0x2,%esi
801020b7:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020b9:	89 1c 24             	mov    %ebx,(%esp)
801020bc:	e8 3f 1f 00 00       	call   80104000 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020c1:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020c6:	85 c0                	test   %eax,%eax
801020c8:	74 05                	je     801020cf <ideintr+0x4f>
    idestart(idequeue);
801020ca:	e8 71 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
801020cf:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801020d6:	e8 15 24 00 00       	call   801044f0 <release>

  release(&idelock);
}
801020db:	83 c4 1c             	add    $0x1c,%esp
801020de:	5b                   	pop    %ebx
801020df:	5e                   	pop    %esi
801020e0:	5f                   	pop    %edi
801020e1:	5d                   	pop    %ebp
801020e2:	c3                   	ret    
801020e3:	90                   	nop
801020e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020e8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ed:	8d 76 00             	lea    0x0(%esi),%esi
801020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f1:	89 c1                	mov    %eax,%ecx
801020f3:	83 e1 c0             	and    $0xffffffc0,%ecx
801020f6:	80 f9 40             	cmp    $0x40,%cl
801020f9:	75 f5                	jne    801020f0 <ideintr+0x70>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020fb:	a8 21                	test   $0x21,%al
801020fd:	75 b2                	jne    801020b1 <ideintr+0x31>
    insl(0x1f0, b->data, BSIZE/4);
801020ff:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102102:	b9 80 00 00 00       	mov    $0x80,%ecx
80102107:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010210c:	fc                   	cld    
8010210d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010210f:	8b 33                	mov    (%ebx),%esi
80102111:	eb 9e                	jmp    801020b1 <ideintr+0x31>
80102113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102120 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	53                   	push   %ebx
80102124:	83 ec 14             	sub    $0x14,%esp
80102127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010212a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010212d:	89 04 24             	mov    %eax,(%esp)
80102130:	e8 8b 21 00 00       	call   801042c0 <holdingsleep>
80102135:	85 c0                	test   %eax,%eax
80102137:	0f 84 9e 00 00 00    	je     801021db <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010213d:	8b 03                	mov    (%ebx),%eax
8010213f:	83 e0 06             	and    $0x6,%eax
80102142:	83 f8 02             	cmp    $0x2,%eax
80102145:	0f 84 a8 00 00 00    	je     801021f3 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010214b:	8b 53 04             	mov    0x4(%ebx),%edx
8010214e:	85 d2                	test   %edx,%edx
80102150:	74 0d                	je     8010215f <iderw+0x3f>
80102152:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102157:	85 c0                	test   %eax,%eax
80102159:	0f 84 88 00 00 00    	je     801021e7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010215f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102166:	e8 15 23 00 00       	call   80104480 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216b:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
80102170:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102177:	85 c0                	test   %eax,%eax
80102179:	75 07                	jne    80102182 <iderw+0x62>
8010217b:	eb 4e                	jmp    801021cb <iderw+0xab>
8010217d:	8d 76 00             	lea    0x0(%esi),%esi
80102180:	89 d0                	mov    %edx,%eax
80102182:	8b 50 58             	mov    0x58(%eax),%edx
80102185:	85 d2                	test   %edx,%edx
80102187:	75 f7                	jne    80102180 <iderw+0x60>
80102189:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
8010218c:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
8010218e:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
80102194:	74 3c                	je     801021d2 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102196:	8b 03                	mov    (%ebx),%eax
80102198:	83 e0 06             	and    $0x6,%eax
8010219b:	83 f8 02             	cmp    $0x2,%eax
8010219e:	74 1a                	je     801021ba <iderw+0x9a>
    sleep(b, &idelock);
801021a0:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
801021a7:	80 
801021a8:	89 1c 24             	mov    %ebx,(%esp)
801021ab:	e8 a0 1b 00 00       	call   80103d50 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021b0:	8b 13                	mov    (%ebx),%edx
801021b2:	83 e2 06             	and    $0x6,%edx
801021b5:	83 fa 02             	cmp    $0x2,%edx
801021b8:	75 e6                	jne    801021a0 <iderw+0x80>
  }


  release(&idelock);
801021ba:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021c1:	83 c4 14             	add    $0x14,%esp
801021c4:	5b                   	pop    %ebx
801021c5:	5d                   	pop    %ebp
  release(&idelock);
801021c6:	e9 25 23 00 00       	jmp    801044f0 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021cb:	b8 64 a5 10 80       	mov    $0x8010a564,%eax
801021d0:	eb ba                	jmp    8010218c <iderw+0x6c>
    idestart(b);
801021d2:	89 d8                	mov    %ebx,%eax
801021d4:	e8 67 fd ff ff       	call   80101f40 <idestart>
801021d9:	eb bb                	jmp    80102196 <iderw+0x76>
    panic("iderw: buf not locked");
801021db:	c7 04 24 aa 71 10 80 	movl   $0x801071aa,(%esp)
801021e2:	e8 79 e1 ff ff       	call   80100360 <panic>
    panic("iderw: ide disk 1 not present");
801021e7:	c7 04 24 d5 71 10 80 	movl   $0x801071d5,(%esp)
801021ee:	e8 6d e1 ff ff       	call   80100360 <panic>
    panic("iderw: nothing to do");
801021f3:	c7 04 24 c0 71 10 80 	movl   $0x801071c0,(%esp)
801021fa:	e8 61 e1 ff ff       	call   80100360 <panic>
801021ff:	90                   	nop

80102200 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	56                   	push   %esi
80102204:	53                   	push   %ebx
80102205:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102208:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
8010220f:	00 c0 fe 
  ioapic->reg = reg;
80102212:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102219:	00 00 00 
  return ioapic->data;
8010221c:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102222:	8b 42 10             	mov    0x10(%edx),%eax
  ioapic->reg = reg;
80102225:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010222b:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102231:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102238:	c1 e8 10             	shr    $0x10,%eax
8010223b:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010223e:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102241:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102244:	39 c2                	cmp    %eax,%edx
80102246:	74 12                	je     8010225a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102248:	c7 04 24 f4 71 10 80 	movl   $0x801071f4,(%esp)
8010224f:	e8 fc e3 ff ff       	call   80100650 <cprintf>
80102254:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010225a:	ba 10 00 00 00       	mov    $0x10,%edx
8010225f:	31 c0                	xor    %eax,%eax
80102261:	eb 07                	jmp    8010226a <ioapicinit+0x6a>
80102263:	90                   	nop
80102264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102268:	89 cb                	mov    %ecx,%ebx
  ioapic->reg = reg;
8010226a:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010226c:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102272:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102275:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  for(i = 0; i <= maxintr; i++){
8010227b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010227e:	89 4b 10             	mov    %ecx,0x10(%ebx)
80102281:	8d 4a 01             	lea    0x1(%edx),%ecx
80102284:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102287:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102289:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010228f:	39 c6                	cmp    %eax,%esi
  ioapic->data = data;
80102291:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
80102298:	7d ce                	jge    80102268 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010229a:	83 c4 10             	add    $0x10,%esp
8010229d:	5b                   	pop    %ebx
8010229e:	5e                   	pop    %esi
8010229f:	5d                   	pop    %ebp
801022a0:	c3                   	ret    
801022a1:	eb 0d                	jmp    801022b0 <ioapicenable>
801022a3:	90                   	nop
801022a4:	90                   	nop
801022a5:	90                   	nop
801022a6:	90                   	nop
801022a7:	90                   	nop
801022a8:	90                   	nop
801022a9:	90                   	nop
801022aa:	90                   	nop
801022ab:	90                   	nop
801022ac:	90                   	nop
801022ad:	90                   	nop
801022ae:	90                   	nop
801022af:	90                   	nop

801022b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	8b 55 08             	mov    0x8(%ebp),%edx
801022b6:	53                   	push   %ebx
801022b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ba:	8d 5a 20             	lea    0x20(%edx),%ebx
801022bd:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
  ioapic->reg = reg;
801022c1:	8b 15 34 26 11 80    	mov    0x80112634,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022c7:	c1 e0 18             	shl    $0x18,%eax
  ioapic->reg = reg;
801022ca:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801022cc:	8b 15 34 26 11 80    	mov    0x80112634,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022d2:	83 c1 01             	add    $0x1,%ecx
  ioapic->data = data;
801022d5:	89 5a 10             	mov    %ebx,0x10(%edx)
  ioapic->reg = reg;
801022d8:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801022da:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801022e0:	89 42 10             	mov    %eax,0x10(%edx)
}
801022e3:	5b                   	pop    %ebx
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	66 90                	xchg   %ax,%ax
801022e8:	66 90                	xchg   %ax,%ax
801022ea:	66 90                	xchg   %ax,%ax
801022ec:	66 90                	xchg   %ax,%ax
801022ee:	66 90                	xchg   %ax,%ax

801022f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	53                   	push   %ebx
801022f4:	83 ec 14             	sub    $0x14,%esp
801022f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102300:	75 7c                	jne    8010237e <kfree+0x8e>
80102302:	81 fb a8 58 11 80    	cmp    $0x801158a8,%ebx
80102308:	72 74                	jb     8010237e <kfree+0x8e>
8010230a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102310:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102315:	77 67                	ja     8010237e <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102317:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010231e:	00 
8010231f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102326:	00 
80102327:	89 1c 24             	mov    %ebx,(%esp)
8010232a:	e8 11 22 00 00       	call   80104540 <memset>

  if(kmem.use_lock)
8010232f:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102335:	85 d2                	test   %edx,%edx
80102337:	75 37                	jne    80102370 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102339:	a1 78 26 11 80       	mov    0x80112678,%eax
8010233e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102340:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102345:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
8010234b:	85 c0                	test   %eax,%eax
8010234d:	75 09                	jne    80102358 <kfree+0x68>
    release(&kmem.lock);
}
8010234f:	83 c4 14             	add    $0x14,%esp
80102352:	5b                   	pop    %ebx
80102353:	5d                   	pop    %ebp
80102354:	c3                   	ret    
80102355:	8d 76 00             	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102358:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010235f:	83 c4 14             	add    $0x14,%esp
80102362:	5b                   	pop    %ebx
80102363:	5d                   	pop    %ebp
    release(&kmem.lock);
80102364:	e9 87 21 00 00       	jmp    801044f0 <release>
80102369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102370:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102377:	e8 04 21 00 00       	call   80104480 <acquire>
8010237c:	eb bb                	jmp    80102339 <kfree+0x49>
    panic("kfree");
8010237e:	c7 04 24 26 72 10 80 	movl   $0x80107226,(%esp)
80102385:	e8 d6 df ff ff       	call   80100360 <panic>
8010238a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102390 <freerange>:
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	56                   	push   %esi
80102394:	53                   	push   %ebx
80102395:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102398:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010239b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010239e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801023a4:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023aa:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801023b0:	39 de                	cmp    %ebx,%esi
801023b2:	73 08                	jae    801023bc <freerange+0x2c>
801023b4:	eb 18                	jmp    801023ce <freerange+0x3e>
801023b6:	66 90                	xchg   %ax,%ax
801023b8:	89 da                	mov    %ebx,%edx
801023ba:	89 c3                	mov    %eax,%ebx
    kfree(p);
801023bc:	89 14 24             	mov    %edx,(%esp)
801023bf:	e8 2c ff ff ff       	call   801022f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801023ca:	39 f0                	cmp    %esi,%eax
801023cc:	76 ea                	jbe    801023b8 <freerange+0x28>
}
801023ce:	83 c4 10             	add    $0x10,%esp
801023d1:	5b                   	pop    %ebx
801023d2:	5e                   	pop    %esi
801023d3:	5d                   	pop    %ebp
801023d4:	c3                   	ret    
801023d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023e0 <kinit1>:
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	56                   	push   %esi
801023e4:	53                   	push   %ebx
801023e5:	83 ec 10             	sub    $0x10,%esp
801023e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023eb:	c7 44 24 04 2c 72 10 	movl   $0x8010722c,0x4(%esp)
801023f2:	80 
801023f3:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801023fa:	e8 11 1f 00 00       	call   80104310 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801023ff:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102402:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102409:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010240c:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102412:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102418:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010241e:	39 de                	cmp    %ebx,%esi
80102420:	73 0a                	jae    8010242c <kinit1+0x4c>
80102422:	eb 1a                	jmp    8010243e <kinit1+0x5e>
80102424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102428:	89 da                	mov    %ebx,%edx
8010242a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010242c:	89 14 24             	mov    %edx,(%esp)
8010242f:	e8 bc fe ff ff       	call   801022f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102434:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010243a:	39 c6                	cmp    %eax,%esi
8010243c:	73 ea                	jae    80102428 <kinit1+0x48>
}
8010243e:	83 c4 10             	add    $0x10,%esp
80102441:	5b                   	pop    %ebx
80102442:	5e                   	pop    %esi
80102443:	5d                   	pop    %ebp
80102444:	c3                   	ret    
80102445:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102450 <kinit2>:
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	56                   	push   %esi
80102454:	53                   	push   %ebx
80102455:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102458:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010245b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010245e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102464:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 08                	jae    8010247c <kinit2+0x2c>
80102474:	eb 18                	jmp    8010248e <kinit2+0x3e>
80102476:	66 90                	xchg   %ax,%ax
80102478:	89 da                	mov    %ebx,%edx
8010247a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010247c:	89 14 24             	mov    %edx,(%esp)
8010247f:	e8 6c fe ff ff       	call   801022f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102484:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010248a:	39 c6                	cmp    %eax,%esi
8010248c:	73 ea                	jae    80102478 <kinit2+0x28>
  kmem.use_lock = 1;
8010248e:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
80102495:	00 00 00 
}
80102498:	83 c4 10             	add    $0x10,%esp
8010249b:	5b                   	pop    %ebx
8010249c:	5e                   	pop    %esi
8010249d:	5d                   	pop    %ebp
8010249e:	c3                   	ret    
8010249f:	90                   	nop

801024a0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	53                   	push   %ebx
801024a4:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
801024a7:	a1 74 26 11 80       	mov    0x80112674,%eax
801024ac:	85 c0                	test   %eax,%eax
801024ae:	75 30                	jne    801024e0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024b0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024b6:	85 db                	test   %ebx,%ebx
801024b8:	74 08                	je     801024c2 <kalloc+0x22>
    kmem.freelist = r->next;
801024ba:	8b 13                	mov    (%ebx),%edx
801024bc:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801024c2:	85 c0                	test   %eax,%eax
801024c4:	74 0c                	je     801024d2 <kalloc+0x32>
    release(&kmem.lock);
801024c6:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024cd:	e8 1e 20 00 00       	call   801044f0 <release>
  return (char*)r;
}
801024d2:	83 c4 14             	add    $0x14,%esp
801024d5:	89 d8                	mov    %ebx,%eax
801024d7:	5b                   	pop    %ebx
801024d8:	5d                   	pop    %ebp
801024d9:	c3                   	ret    
801024da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801024e0:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024e7:	e8 94 1f 00 00       	call   80104480 <acquire>
801024ec:	a1 74 26 11 80       	mov    0x80112674,%eax
801024f1:	eb bd                	jmp    801024b0 <kalloc+0x10>
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102500:	ba 64 00 00 00       	mov    $0x64,%edx
80102505:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102506:	a8 01                	test   $0x1,%al
80102508:	0f 84 ba 00 00 00    	je     801025c8 <kbdgetc+0xc8>
8010250e:	b2 60                	mov    $0x60,%dl
80102510:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102511:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102514:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010251a:	0f 84 88 00 00 00    	je     801025a8 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102520:	84 c0                	test   %al,%al
80102522:	79 2c                	jns    80102550 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102524:	8b 15 b4 a5 10 80    	mov    0x8010a5b4,%edx
8010252a:	f6 c2 40             	test   $0x40,%dl
8010252d:	75 05                	jne    80102534 <kbdgetc+0x34>
8010252f:	89 c1                	mov    %eax,%ecx
80102531:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102534:	0f b6 81 60 73 10 80 	movzbl -0x7fef8ca0(%ecx),%eax
8010253b:	83 c8 40             	or     $0x40,%eax
8010253e:	0f b6 c0             	movzbl %al,%eax
80102541:	f7 d0                	not    %eax
80102543:	21 d0                	and    %edx,%eax
80102545:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010254a:	31 c0                	xor    %eax,%eax
8010254c:	c3                   	ret    
8010254d:	8d 76 00             	lea    0x0(%esi),%esi
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	53                   	push   %ebx
80102554:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
  } else if(shift & E0ESC){
8010255a:	f6 c3 40             	test   $0x40,%bl
8010255d:	74 09                	je     80102568 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010255f:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102562:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102565:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102568:	0f b6 91 60 73 10 80 	movzbl -0x7fef8ca0(%ecx),%edx
  shift ^= togglecode[data];
8010256f:	0f b6 81 60 72 10 80 	movzbl -0x7fef8da0(%ecx),%eax
  shift |= shiftcode[data];
80102576:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102578:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010257a:	89 d0                	mov    %edx,%eax
8010257c:	83 e0 03             	and    $0x3,%eax
8010257f:	8b 04 85 40 72 10 80 	mov    -0x7fef8dc0(,%eax,4),%eax
  shift ^= togglecode[data];
80102586:	89 15 b4 a5 10 80    	mov    %edx,0x8010a5b4
  if(shift & CAPSLOCK){
8010258c:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010258f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102593:	74 0b                	je     801025a0 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
80102595:	8d 50 9f             	lea    -0x61(%eax),%edx
80102598:	83 fa 19             	cmp    $0x19,%edx
8010259b:	77 1b                	ja     801025b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010259d:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025a0:	5b                   	pop    %ebx
801025a1:	5d                   	pop    %ebp
801025a2:	c3                   	ret    
801025a3:	90                   	nop
801025a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025a8:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801025af:	31 c0                	xor    %eax,%eax
801025b1:	c3                   	ret    
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801025b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025bb:	8d 50 20             	lea    0x20(%eax),%edx
801025be:	83 f9 19             	cmp    $0x19,%ecx
801025c1:	0f 46 c2             	cmovbe %edx,%eax
  return c;
801025c4:	eb da                	jmp    801025a0 <kbdgetc+0xa0>
801025c6:	66 90                	xchg   %ax,%ax
    return -1;
801025c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax

801025d0 <kbdintr>:

void
kbdintr(void)
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801025d6:	c7 04 24 00 25 10 80 	movl   $0x80102500,(%esp)
801025dd:	e8 ce e1 ff ff       	call   801007b0 <consoleintr>
}
801025e2:	c9                   	leave  
801025e3:	c3                   	ret    
801025e4:	66 90                	xchg   %ax,%ax
801025e6:	66 90                	xchg   %ax,%ax
801025e8:	66 90                	xchg   %ax,%ax
801025ea:	66 90                	xchg   %ax,%ax
801025ec:	66 90                	xchg   %ax,%ax
801025ee:	66 90                	xchg   %ax,%ax

801025f0 <fill_rtcdate>:
  return inb(CMOS_RETURN);
}

static void
fill_rtcdate(struct rtcdate *r)
{
801025f0:	55                   	push   %ebp
801025f1:	89 c1                	mov    %eax,%ecx
801025f3:	89 e5                	mov    %esp,%ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025f5:	ba 70 00 00 00       	mov    $0x70,%edx
801025fa:	53                   	push   %ebx
801025fb:	31 c0                	xor    %eax,%eax
801025fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025fe:	bb 71 00 00 00       	mov    $0x71,%ebx
80102603:	89 da                	mov    %ebx,%edx
80102605:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102606:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102609:	b2 70                	mov    $0x70,%dl
8010260b:	89 01                	mov    %eax,(%ecx)
8010260d:	b8 02 00 00 00       	mov    $0x2,%eax
80102612:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102613:	89 da                	mov    %ebx,%edx
80102615:	ec                   	in     (%dx),%al
80102616:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102619:	b2 70                	mov    $0x70,%dl
8010261b:	89 41 04             	mov    %eax,0x4(%ecx)
8010261e:	b8 04 00 00 00       	mov    $0x4,%eax
80102623:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102624:	89 da                	mov    %ebx,%edx
80102626:	ec                   	in     (%dx),%al
80102627:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010262a:	b2 70                	mov    $0x70,%dl
8010262c:	89 41 08             	mov    %eax,0x8(%ecx)
8010262f:	b8 07 00 00 00       	mov    $0x7,%eax
80102634:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102635:	89 da                	mov    %ebx,%edx
80102637:	ec                   	in     (%dx),%al
80102638:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010263b:	b2 70                	mov    $0x70,%dl
8010263d:	89 41 0c             	mov    %eax,0xc(%ecx)
80102640:	b8 08 00 00 00       	mov    $0x8,%eax
80102645:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102646:	89 da                	mov    %ebx,%edx
80102648:	ec                   	in     (%dx),%al
80102649:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010264c:	b2 70                	mov    $0x70,%dl
8010264e:	89 41 10             	mov    %eax,0x10(%ecx)
80102651:	b8 09 00 00 00       	mov    $0x9,%eax
80102656:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102657:	89 da                	mov    %ebx,%edx
80102659:	ec                   	in     (%dx),%al
8010265a:	0f b6 d8             	movzbl %al,%ebx
8010265d:	89 59 14             	mov    %ebx,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
80102660:	5b                   	pop    %ebx
80102661:	5d                   	pop    %ebp
80102662:	c3                   	ret    
80102663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102670 <lapicinit>:
  if(!lapic)
80102670:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102675:	55                   	push   %ebp
80102676:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102678:	85 c0                	test   %eax,%eax
8010267a:	0f 84 c0 00 00 00    	je     80102740 <lapicinit+0xd0>
  lapic[index] = value;
80102680:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102687:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010268d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102694:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102697:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010269a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026a1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026a4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026ae:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026b1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026bb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026c8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026cb:	8b 50 20             	mov    0x20(%eax),%edx
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ce:	8b 50 30             	mov    0x30(%eax),%edx
801026d1:	c1 ea 10             	shr    $0x10,%edx
801026d4:	80 fa 03             	cmp    $0x3,%dl
801026d7:	77 6f                	ja     80102748 <lapicinit+0xd8>
  lapic[index] = value;
801026d9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026e0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ed:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026f3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026fa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026fd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102700:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102707:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010270a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010270d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102714:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102717:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010271a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102721:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102724:	8b 50 20             	mov    0x20(%eax),%edx
80102727:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
80102728:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010272e:	80 e6 10             	and    $0x10,%dh
80102731:	75 f5                	jne    80102728 <lapicinit+0xb8>
  lapic[index] = value;
80102733:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010273a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010273d:	8b 40 20             	mov    0x20(%eax),%eax
}
80102740:	5d                   	pop    %ebp
80102741:	c3                   	ret    
80102742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102748:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010274f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102752:	8b 50 20             	mov    0x20(%eax),%edx
80102755:	eb 82                	jmp    801026d9 <lapicinit+0x69>
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapicid>:
  if (!lapic)
80102760:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 0c                	je     80102778 <lapicid+0x18>
  return lapic[ID] >> 24;
8010276c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010276f:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
80102770:	c1 e8 18             	shr    $0x18,%eax
}
80102773:	c3                   	ret    
80102774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102778:	31 c0                	xor    %eax,%eax
}
8010277a:	5d                   	pop    %ebp
8010277b:	c3                   	ret    
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <lapiceoi>:
  if(lapic)
80102780:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102785:	55                   	push   %ebp
80102786:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102788:	85 c0                	test   %eax,%eax
8010278a:	74 0d                	je     80102799 <lapiceoi+0x19>
  lapic[index] = value;
8010278c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102793:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102796:	8b 40 20             	mov    0x20(%eax),%eax
}
80102799:	5d                   	pop    %ebp
8010279a:	c3                   	ret    
8010279b:	90                   	nop
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027a0 <microdelay>:
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
}
801027a3:	5d                   	pop    %ebp
801027a4:	c3                   	ret    
801027a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027b0 <lapicstartap>:
{
801027b0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b1:	ba 70 00 00 00       	mov    $0x70,%edx
801027b6:	89 e5                	mov    %esp,%ebp
801027b8:	b8 0f 00 00 00       	mov    $0xf,%eax
801027bd:	53                   	push   %ebx
801027be:	8b 4d 08             	mov    0x8(%ebp),%ecx
801027c1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801027c4:	ee                   	out    %al,(%dx)
801027c5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ca:	b2 71                	mov    $0x71,%dl
801027cc:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
801027cd:	31 c0                	xor    %eax,%eax
801027cf:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027d5:	89 d8                	mov    %ebx,%eax
801027d7:	c1 e8 04             	shr    $0x4,%eax
801027da:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027e0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(ICRHI, apicid<<24);
801027e5:	c1 e1 18             	shl    $0x18,%ecx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027e8:	c1 eb 0c             	shr    $0xc,%ebx
  lapic[index] = value;
801027eb:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f4:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027fb:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102801:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102808:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010280b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010280e:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102814:	8b 50 20             	mov    0x20(%eax),%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102817:	89 da                	mov    %ebx,%edx
80102819:	80 ce 06             	or     $0x6,%dh
  lapic[index] = value;
8010281c:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102822:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102825:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010282b:	8b 48 20             	mov    0x20(%eax),%ecx
  lapic[index] = value;
8010282e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102834:	8b 40 20             	mov    0x20(%eax),%eax
}
80102837:	5b                   	pop    %ebx
80102838:	5d                   	pop    %ebp
80102839:	c3                   	ret    
8010283a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102840 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102840:	55                   	push   %ebp
80102841:	ba 70 00 00 00       	mov    $0x70,%edx
80102846:	89 e5                	mov    %esp,%ebp
80102848:	b8 0b 00 00 00       	mov    $0xb,%eax
8010284d:	57                   	push   %edi
8010284e:	56                   	push   %esi
8010284f:	53                   	push   %ebx
80102850:	83 ec 4c             	sub    $0x4c,%esp
80102853:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102854:	b2 71                	mov    $0x71,%dl
80102856:	ec                   	in     (%dx),%al
80102857:	88 45 b7             	mov    %al,-0x49(%ebp)
8010285a:	8d 5d b8             	lea    -0x48(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010285d:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102861:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102868:	be 70 00 00 00       	mov    $0x70,%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010286d:	89 d8                	mov    %ebx,%eax
8010286f:	e8 7c fd ff ff       	call   801025f0 <fill_rtcdate>
80102874:	b8 0a 00 00 00       	mov    $0xa,%eax
80102879:	89 f2                	mov    %esi,%edx
8010287b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287c:	ba 71 00 00 00       	mov    $0x71,%edx
80102881:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102882:	84 c0                	test   %al,%al
80102884:	78 e7                	js     8010286d <cmostime+0x2d>
        continue;
    fill_rtcdate(&t2);
80102886:	89 f8                	mov    %edi,%eax
80102888:	e8 63 fd ff ff       	call   801025f0 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010288d:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
80102894:	00 
80102895:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102899:	89 1c 24             	mov    %ebx,(%esp)
8010289c:	e8 ef 1c 00 00       	call   80104590 <memcmp>
801028a1:	85 c0                	test   %eax,%eax
801028a3:	75 c3                	jne    80102868 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801028a5:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028a9:	75 78                	jne    80102923 <cmostime+0xe3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801028ab:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028ae:	89 c2                	mov    %eax,%edx
801028b0:	83 e0 0f             	and    $0xf,%eax
801028b3:	c1 ea 04             	shr    $0x4,%edx
801028b6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028b9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028bc:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801028bf:	8b 45 bc             	mov    -0x44(%ebp),%eax
801028c2:	89 c2                	mov    %eax,%edx
801028c4:	83 e0 0f             	and    $0xf,%eax
801028c7:	c1 ea 04             	shr    $0x4,%edx
801028ca:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028cd:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028d0:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801028d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801028d6:	89 c2                	mov    %eax,%edx
801028d8:	83 e0 0f             	and    $0xf,%eax
801028db:	c1 ea 04             	shr    $0x4,%edx
801028de:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028e1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028e4:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801028e7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801028ea:	89 c2                	mov    %eax,%edx
801028ec:	83 e0 0f             	and    $0xf,%eax
801028ef:	c1 ea 04             	shr    $0x4,%edx
801028f2:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028f5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028f8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801028fb:	8b 45 c8             	mov    -0x38(%ebp),%eax
801028fe:	89 c2                	mov    %eax,%edx
80102900:	83 e0 0f             	and    $0xf,%eax
80102903:	c1 ea 04             	shr    $0x4,%edx
80102906:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102909:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010290c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010290f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102912:	89 c2                	mov    %eax,%edx
80102914:	83 e0 0f             	and    $0xf,%eax
80102917:	c1 ea 04             	shr    $0x4,%edx
8010291a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010291d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102920:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102923:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102926:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102929:	89 01                	mov    %eax,(%ecx)
8010292b:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010292e:	89 41 04             	mov    %eax,0x4(%ecx)
80102931:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102934:	89 41 08             	mov    %eax,0x8(%ecx)
80102937:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010293a:	89 41 0c             	mov    %eax,0xc(%ecx)
8010293d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102940:	89 41 10             	mov    %eax,0x10(%ecx)
80102943:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102946:	89 41 14             	mov    %eax,0x14(%ecx)
  r->year += 2000;
80102949:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
}
80102950:	83 c4 4c             	add    $0x4c,%esp
80102953:	5b                   	pop    %ebx
80102954:	5e                   	pop    %esi
80102955:	5f                   	pop    %edi
80102956:	5d                   	pop    %ebp
80102957:	c3                   	ret    
80102958:	66 90                	xchg   %ax,%ax
8010295a:	66 90                	xchg   %ax,%ax
8010295c:	66 90                	xchg   %ax,%ax
8010295e:	66 90                	xchg   %ax,%ax

80102960 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	57                   	push   %edi
80102964:	56                   	push   %esi
80102965:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102966:	31 db                	xor    %ebx,%ebx
{
80102968:	83 ec 1c             	sub    $0x1c,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010296b:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102970:	85 c0                	test   %eax,%eax
80102972:	7e 78                	jle    801029ec <install_trans+0x8c>
80102974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102978:	a1 b4 26 11 80       	mov    0x801126b4,%eax
8010297d:	01 d8                	add    %ebx,%eax
8010297f:	83 c0 01             	add    $0x1,%eax
80102982:	89 44 24 04          	mov    %eax,0x4(%esp)
80102986:	a1 c4 26 11 80       	mov    0x801126c4,%eax
8010298b:	89 04 24             	mov    %eax,(%esp)
8010298e:	e8 3d d7 ff ff       	call   801000d0 <bread>
80102993:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102995:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
8010299c:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010299f:	89 44 24 04          	mov    %eax,0x4(%esp)
801029a3:	a1 c4 26 11 80       	mov    0x801126c4,%eax
801029a8:	89 04 24             	mov    %eax,(%esp)
801029ab:	e8 20 d7 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029b0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801029b7:	00 
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029b8:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029ba:	8d 47 5c             	lea    0x5c(%edi),%eax
801029bd:	89 44 24 04          	mov    %eax,0x4(%esp)
801029c1:	8d 46 5c             	lea    0x5c(%esi),%eax
801029c4:	89 04 24             	mov    %eax,(%esp)
801029c7:	e8 14 1c 00 00       	call   801045e0 <memmove>
    bwrite(dbuf);  // write dst to disk
801029cc:	89 34 24             	mov    %esi,(%esp)
801029cf:	e8 cc d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
801029d4:	89 3c 24             	mov    %edi,(%esp)
801029d7:	e8 04 d8 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
801029dc:	89 34 24             	mov    %esi,(%esp)
801029df:	e8 fc d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801029e4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
801029ea:	7f 8c                	jg     80102978 <install_trans+0x18>
  }
}
801029ec:	83 c4 1c             	add    $0x1c,%esp
801029ef:	5b                   	pop    %ebx
801029f0:	5e                   	pop    %esi
801029f1:	5f                   	pop    %edi
801029f2:	5d                   	pop    %ebp
801029f3:	c3                   	ret    
801029f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102a00 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a00:	55                   	push   %ebp
80102a01:	89 e5                	mov    %esp,%ebp
80102a03:	57                   	push   %edi
80102a04:	56                   	push   %esi
80102a05:	53                   	push   %ebx
80102a06:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a09:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a0e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a12:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102a17:	89 04 24             	mov    %eax,(%esp)
80102a1a:	e8 b1 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a1f:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102a25:	31 d2                	xor    %edx,%edx
80102a27:	85 db                	test   %ebx,%ebx
  struct buf *buf = bread(log.dev, log.start);
80102a29:	89 c7                	mov    %eax,%edi
  hb->n = log.lh.n;
80102a2b:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102a2e:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102a31:	7e 17                	jle    80102a4a <write_head+0x4a>
80102a33:	90                   	nop
80102a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102a38:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102a3f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102a43:	83 c2 01             	add    $0x1,%edx
80102a46:	39 da                	cmp    %ebx,%edx
80102a48:	75 ee                	jne    80102a38 <write_head+0x38>
  }
  bwrite(buf);
80102a4a:	89 3c 24             	mov    %edi,(%esp)
80102a4d:	e8 4e d7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102a52:	89 3c 24             	mov    %edi,(%esp)
80102a55:	e8 86 d7 ff ff       	call   801001e0 <brelse>
}
80102a5a:	83 c4 1c             	add    $0x1c,%esp
80102a5d:	5b                   	pop    %ebx
80102a5e:	5e                   	pop    %esi
80102a5f:	5f                   	pop    %edi
80102a60:	5d                   	pop    %ebp
80102a61:	c3                   	ret    
80102a62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a70 <initlog>:
{
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	56                   	push   %esi
80102a74:	53                   	push   %ebx
80102a75:	83 ec 30             	sub    $0x30,%esp
80102a78:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102a7b:	c7 44 24 04 60 74 10 	movl   $0x80107460,0x4(%esp)
80102a82:	80 
80102a83:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102a8a:	e8 81 18 00 00       	call   80104310 <initlock>
  readsb(dev, &sb);
80102a8f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102a92:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a96:	89 1c 24             	mov    %ebx,(%esp)
80102a99:	e8 82 e9 ff ff       	call   80101420 <readsb>
  log.start = sb.logstart;
80102a9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102aa1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  struct buf *buf = bread(log.dev, log.start);
80102aa4:	89 1c 24             	mov    %ebx,(%esp)
  log.dev = dev;
80102aa7:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  struct buf *buf = bread(log.dev, log.start);
80102aad:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.size = sb.nlog;
80102ab1:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102ab7:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102abc:	e8 0f d6 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102ac1:	31 d2                	xor    %edx,%edx
  log.lh.n = lh->n;
80102ac3:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ac6:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102ac9:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102acb:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102ad1:	7e 17                	jle    80102aea <initlog+0x7a>
80102ad3:	90                   	nop
80102ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102ad8:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102adc:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102ae3:	83 c2 01             	add    $0x1,%edx
80102ae6:	39 da                	cmp    %ebx,%edx
80102ae8:	75 ee                	jne    80102ad8 <initlog+0x68>
  brelse(buf);
80102aea:	89 04 24             	mov    %eax,(%esp)
80102aed:	e8 ee d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102af2:	e8 69 fe ff ff       	call   80102960 <install_trans>
  log.lh.n = 0;
80102af7:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102afe:	00 00 00 
  write_head(); // clear the log
80102b01:	e8 fa fe ff ff       	call   80102a00 <write_head>
}
80102b06:	83 c4 30             	add    $0x30,%esp
80102b09:	5b                   	pop    %ebx
80102b0a:	5e                   	pop    %esi
80102b0b:	5d                   	pop    %ebp
80102b0c:	c3                   	ret    
80102b0d:	8d 76 00             	lea    0x0(%esi),%esi

80102b10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102b16:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b1d:	e8 5e 19 00 00       	call   80104480 <acquire>
80102b22:	eb 18                	jmp    80102b3c <begin_op+0x2c>
80102b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b28:	c7 44 24 04 80 26 11 	movl   $0x80112680,0x4(%esp)
80102b2f:	80 
80102b30:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b37:	e8 14 12 00 00       	call   80103d50 <sleep>
    if(log.committing){
80102b3c:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102b41:	85 c0                	test   %eax,%eax
80102b43:	75 e3                	jne    80102b28 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b45:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102b4a:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102b50:	83 c0 01             	add    $0x1,%eax
80102b53:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b56:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b59:	83 fa 1e             	cmp    $0x1e,%edx
80102b5c:	7f ca                	jg     80102b28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102b5e:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
      log.outstanding += 1;
80102b65:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102b6a:	e8 81 19 00 00       	call   801044f0 <release>
      break;
    }
  }
}
80102b6f:	c9                   	leave  
80102b70:	c3                   	ret    
80102b71:	eb 0d                	jmp    80102b80 <end_op>
80102b73:	90                   	nop
80102b74:	90                   	nop
80102b75:	90                   	nop
80102b76:	90                   	nop
80102b77:	90                   	nop
80102b78:	90                   	nop
80102b79:	90                   	nop
80102b7a:	90                   	nop
80102b7b:	90                   	nop
80102b7c:	90                   	nop
80102b7d:	90                   	nop
80102b7e:	90                   	nop
80102b7f:	90                   	nop

80102b80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	57                   	push   %edi
80102b84:	56                   	push   %esi
80102b85:	53                   	push   %ebx
80102b86:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102b89:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b90:	e8 eb 18 00 00       	call   80104480 <acquire>
  log.outstanding -= 1;
80102b95:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102b9a:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
  log.outstanding -= 1;
80102ba0:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102ba3:	85 d2                	test   %edx,%edx
  log.outstanding -= 1;
80102ba5:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102baa:	0f 85 f3 00 00 00    	jne    80102ca3 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102bb0:	85 c0                	test   %eax,%eax
80102bb2:	0f 85 cb 00 00 00    	jne    80102c83 <end_op+0x103>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102bb8:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102bbf:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
80102bc1:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102bc8:	00 00 00 
  release(&log.lock);
80102bcb:	e8 20 19 00 00       	call   801044f0 <release>
  if (log.lh.n > 0) {
80102bd0:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102bd5:	85 c0                	test   %eax,%eax
80102bd7:	0f 8e 90 00 00 00    	jle    80102c6d <end_op+0xed>
80102bdd:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102be0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102be5:	01 d8                	add    %ebx,%eax
80102be7:	83 c0 01             	add    $0x1,%eax
80102bea:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bee:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102bf3:	89 04 24             	mov    %eax,(%esp)
80102bf6:	e8 d5 d4 ff ff       	call   801000d0 <bread>
80102bfb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102bfd:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102c04:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c07:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c0b:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102c10:	89 04 24             	mov    %eax,(%esp)
80102c13:	e8 b8 d4 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102c18:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102c1f:	00 
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c20:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c22:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c25:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c29:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c2c:	89 04 24             	mov    %eax,(%esp)
80102c2f:	e8 ac 19 00 00       	call   801045e0 <memmove>
    bwrite(to);  // write the log
80102c34:	89 34 24             	mov    %esi,(%esp)
80102c37:	e8 64 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c3c:	89 3c 24             	mov    %edi,(%esp)
80102c3f:	e8 9c d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102c44:	89 34 24             	mov    %esi,(%esp)
80102c47:	e8 94 d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c4c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102c52:	7c 8c                	jl     80102be0 <end_op+0x60>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102c54:	e8 a7 fd ff ff       	call   80102a00 <write_head>
    install_trans(); // Now install writes to home locations
80102c59:	e8 02 fd ff ff       	call   80102960 <install_trans>
    log.lh.n = 0;
80102c5e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c65:	00 00 00 
    write_head();    // Erase the transaction from the log
80102c68:	e8 93 fd ff ff       	call   80102a00 <write_head>
    acquire(&log.lock);
80102c6d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c74:	e8 07 18 00 00       	call   80104480 <acquire>
    log.committing = 0;
80102c79:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102c80:	00 00 00 
    wakeup(&log);
80102c83:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c8a:	e8 71 13 00 00       	call   80104000 <wakeup>
    release(&log.lock);
80102c8f:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c96:	e8 55 18 00 00       	call   801044f0 <release>
}
80102c9b:	83 c4 1c             	add    $0x1c,%esp
80102c9e:	5b                   	pop    %ebx
80102c9f:	5e                   	pop    %esi
80102ca0:	5f                   	pop    %edi
80102ca1:	5d                   	pop    %ebp
80102ca2:	c3                   	ret    
    panic("log.committing");
80102ca3:	c7 04 24 64 74 10 80 	movl   $0x80107464,(%esp)
80102caa:	e8 b1 d6 ff ff       	call   80100360 <panic>
80102caf:	90                   	nop

80102cb0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102cb7:	a1 c8 26 11 80       	mov    0x801126c8,%eax
{
80102cbc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102cbf:	83 f8 1d             	cmp    $0x1d,%eax
80102cc2:	0f 8f 98 00 00 00    	jg     80102d60 <log_write+0xb0>
80102cc8:	8b 0d b8 26 11 80    	mov    0x801126b8,%ecx
80102cce:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102cd1:	39 d0                	cmp    %edx,%eax
80102cd3:	0f 8d 87 00 00 00    	jge    80102d60 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102cd9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102cde:	85 c0                	test   %eax,%eax
80102ce0:	0f 8e 86 00 00 00    	jle    80102d6c <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102ce6:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102ced:	e8 8e 17 00 00       	call   80104480 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102cf2:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102cf8:	83 fa 00             	cmp    $0x0,%edx
80102cfb:	7e 54                	jle    80102d51 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102cfd:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102d00:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d02:	39 0d cc 26 11 80    	cmp    %ecx,0x801126cc
80102d08:	75 0f                	jne    80102d19 <log_write+0x69>
80102d0a:	eb 3c                	jmp    80102d48 <log_write+0x98>
80102d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d10:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102d17:	74 2f                	je     80102d48 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102d19:	83 c0 01             	add    $0x1,%eax
80102d1c:	39 d0                	cmp    %edx,%eax
80102d1e:	75 f0                	jne    80102d10 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102d20:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d27:	83 c2 01             	add    $0x1,%edx
80102d2a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102d30:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102d33:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102d3a:	83 c4 14             	add    $0x14,%esp
80102d3d:	5b                   	pop    %ebx
80102d3e:	5d                   	pop    %ebp
  release(&log.lock);
80102d3f:	e9 ac 17 00 00       	jmp    801044f0 <release>
80102d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  log.lh.block[i] = b->blockno;
80102d48:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102d4f:	eb df                	jmp    80102d30 <log_write+0x80>
80102d51:	8b 43 08             	mov    0x8(%ebx),%eax
80102d54:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102d59:	75 d5                	jne    80102d30 <log_write+0x80>
80102d5b:	eb ca                	jmp    80102d27 <log_write+0x77>
80102d5d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("too big a transaction");
80102d60:	c7 04 24 73 74 10 80 	movl   $0x80107473,(%esp)
80102d67:	e8 f4 d5 ff ff       	call   80100360 <panic>
    panic("log_write outside of trans");
80102d6c:	c7 04 24 89 74 10 80 	movl   $0x80107489,(%esp)
80102d73:	e8 e8 d5 ff ff       	call   80100360 <panic>
80102d78:	66 90                	xchg   %ax,%ax
80102d7a:	66 90                	xchg   %ax,%ax
80102d7c:	66 90                	xchg   %ax,%ax
80102d7e:	66 90                	xchg   %ax,%ax

80102d80 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102d87:	e8 44 09 00 00       	call   801036d0 <cpuid>
80102d8c:	89 c3                	mov    %eax,%ebx
80102d8e:	e8 3d 09 00 00       	call   801036d0 <cpuid>
80102d93:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102d97:	c7 04 24 a4 74 10 80 	movl   $0x801074a4,(%esp)
80102d9e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102da2:	e8 a9 d8 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102da7:	e8 a4 2a 00 00       	call   80105850 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102dac:	e8 9f 08 00 00       	call   80103650 <mycpu>
80102db1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102db3:	b8 01 00 00 00       	mov    $0x1,%eax
80102db8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102dbf:	e8 ec 0b 00 00       	call   801039b0 <scheduler>
80102dc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102dca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102dd0 <mpenter>:
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102dd6:	e8 45 3b 00 00       	call   80106920 <switchkvm>
  seginit();
80102ddb:	e8 80 3a 00 00       	call   80106860 <seginit>
  lapicinit();
80102de0:	e8 8b f8 ff ff       	call   80102670 <lapicinit>
  mpmain();
80102de5:	e8 96 ff ff ff       	call   80102d80 <mpmain>
80102dea:	66 90                	xchg   %ax,%ax
80102dec:	66 90                	xchg   %ax,%ax
80102dee:	66 90                	xchg   %ax,%ax

80102df0 <main>:
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102df4:	bb 80 27 11 80       	mov    $0x80112780,%ebx
{
80102df9:	83 e4 f0             	and    $0xfffffff0,%esp
80102dfc:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102dff:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102e06:	80 
80102e07:	c7 04 24 a8 58 11 80 	movl   $0x801158a8,(%esp)
80102e0e:	e8 cd f5 ff ff       	call   801023e0 <kinit1>
  kvmalloc();      // kernel page table
80102e13:	e8 98 3f 00 00       	call   80106db0 <kvmalloc>
  mpinit();        // detect other processors
80102e18:	e8 73 01 00 00       	call   80102f90 <mpinit>
80102e1d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102e20:	e8 4b f8 ff ff       	call   80102670 <lapicinit>
  seginit();       // segment descriptors
80102e25:	e8 36 3a 00 00       	call   80106860 <seginit>
  picinit();       // disable pic
80102e2a:	e8 21 03 00 00       	call   80103150 <picinit>
80102e2f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102e30:	e8 cb f3 ff ff       	call   80102200 <ioapicinit>
  consoleinit();   // console hardware
80102e35:	e8 16 db ff ff       	call   80100950 <consoleinit>
  uartinit();      // serial port
80102e3a:	e8 41 2d 00 00       	call   80105b80 <uartinit>
80102e3f:	90                   	nop
  pinit();         // process table
80102e40:	e8 eb 07 00 00       	call   80103630 <pinit>
  tvinit();        // trap vectors
80102e45:	e8 66 29 00 00       	call   801057b0 <tvinit>
  binit();         // buffer cache
80102e4a:	e8 f1 d1 ff ff       	call   80100040 <binit>
80102e4f:	90                   	nop
  fileinit();      // file table
80102e50:	e8 fb de ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80102e55:	e8 a6 f1 ff ff       	call   80102000 <ideinit>
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102e5a:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102e61:	00 
80102e62:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102e69:	80 
80102e6a:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102e71:	e8 6a 17 00 00       	call   801045e0 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
80102e76:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102e7d:	00 00 00 
80102e80:	05 80 27 11 80       	add    $0x80112780,%eax
80102e85:	39 d8                	cmp    %ebx,%eax
80102e87:	76 6a                	jbe    80102ef3 <main+0x103>
80102e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102e90:	e8 bb 07 00 00       	call   80103650 <mycpu>
80102e95:	39 d8                	cmp    %ebx,%eax
80102e97:	74 41                	je     80102eda <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102e99:	e8 02 f6 ff ff       	call   801024a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102e9e:	c7 05 f8 6f 00 80 d0 	movl   $0x80102dd0,0x80006ff8
80102ea5:	2d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102ea8:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102eaf:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102eb2:	05 00 10 00 00       	add    $0x1000,%eax
80102eb7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102ebc:	0f b6 03             	movzbl (%ebx),%eax
80102ebf:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102ec6:	00 
80102ec7:	89 04 24             	mov    %eax,(%esp)
80102eca:	e8 e1 f8 ff ff       	call   801027b0 <lapicstartap>
80102ecf:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102ed0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102ed6:	85 c0                	test   %eax,%eax
80102ed8:	74 f6                	je     80102ed0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102eda:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ee1:	00 00 00 
80102ee4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102eea:	05 80 27 11 80       	add    $0x80112780,%eax
80102eef:	39 c3                	cmp    %eax,%ebx
80102ef1:	72 9d                	jb     80102e90 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102ef3:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102efa:	8e 
80102efb:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102f02:	e8 49 f5 ff ff       	call   80102450 <kinit2>
  userinit();      // first user process
80102f07:	e8 14 08 00 00       	call   80103720 <userinit>
  mpmain();        // finish this processor's setup
80102f0c:	e8 6f fe ff ff       	call   80102d80 <mpmain>
80102f11:	66 90                	xchg   %ax,%ax
80102f13:	66 90                	xchg   %ax,%ax
80102f15:	66 90                	xchg   %ax,%ax
80102f17:	66 90                	xchg   %ax,%ax
80102f19:	66 90                	xchg   %ax,%ax
80102f1b:	66 90                	xchg   %ax,%ax
80102f1d:	66 90                	xchg   %ax,%ax
80102f1f:	90                   	nop

80102f20 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102f24:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102f2a:	53                   	push   %ebx
  e = addr+len;
80102f2b:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102f2e:	83 ec 10             	sub    $0x10,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102f31:	39 de                	cmp    %ebx,%esi
80102f33:	73 3c                	jae    80102f71 <mpsearch1+0x51>
80102f35:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f38:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102f3f:	00 
80102f40:	c7 44 24 04 b8 74 10 	movl   $0x801074b8,0x4(%esp)
80102f47:	80 
80102f48:	89 34 24             	mov    %esi,(%esp)
80102f4b:	e8 40 16 00 00       	call   80104590 <memcmp>
80102f50:	85 c0                	test   %eax,%eax
80102f52:	75 16                	jne    80102f6a <mpsearch1+0x4a>
80102f54:	31 c9                	xor    %ecx,%ecx
80102f56:	31 d2                	xor    %edx,%edx
    sum += addr[i];
80102f58:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
  for(i=0; i<len; i++)
80102f5c:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80102f5f:	01 c1                	add    %eax,%ecx
  for(i=0; i<len; i++)
80102f61:	83 fa 10             	cmp    $0x10,%edx
80102f64:	75 f2                	jne    80102f58 <mpsearch1+0x38>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f66:	84 c9                	test   %cl,%cl
80102f68:	74 10                	je     80102f7a <mpsearch1+0x5a>
  for(p = addr; p < e; p += sizeof(struct mp))
80102f6a:	83 c6 10             	add    $0x10,%esi
80102f6d:	39 f3                	cmp    %esi,%ebx
80102f6f:	77 c7                	ja     80102f38 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
}
80102f71:	83 c4 10             	add    $0x10,%esp
  return 0;
80102f74:	31 c0                	xor    %eax,%eax
}
80102f76:	5b                   	pop    %ebx
80102f77:	5e                   	pop    %esi
80102f78:	5d                   	pop    %ebp
80102f79:	c3                   	ret    
80102f7a:	83 c4 10             	add    $0x10,%esp
80102f7d:	89 f0                	mov    %esi,%eax
80102f7f:	5b                   	pop    %ebx
80102f80:	5e                   	pop    %esi
80102f81:	5d                   	pop    %ebp
80102f82:	c3                   	ret    
80102f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f90 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	57                   	push   %edi
80102f94:	56                   	push   %esi
80102f95:	53                   	push   %ebx
80102f96:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102f99:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102fa0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102fa7:	c1 e0 08             	shl    $0x8,%eax
80102faa:	09 d0                	or     %edx,%eax
80102fac:	c1 e0 04             	shl    $0x4,%eax
80102faf:	85 c0                	test   %eax,%eax
80102fb1:	75 1b                	jne    80102fce <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102fb3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102fba:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102fc1:	c1 e0 08             	shl    $0x8,%eax
80102fc4:	09 d0                	or     %edx,%eax
80102fc6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102fc9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80102fce:	ba 00 04 00 00       	mov    $0x400,%edx
80102fd3:	e8 48 ff ff ff       	call   80102f20 <mpsearch1>
80102fd8:	85 c0                	test   %eax,%eax
80102fda:	89 c7                	mov    %eax,%edi
80102fdc:	0f 84 22 01 00 00    	je     80103104 <mpinit+0x174>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102fe2:	8b 77 04             	mov    0x4(%edi),%esi
80102fe5:	85 f6                	test   %esi,%esi
80102fe7:	0f 84 30 01 00 00    	je     8010311d <mpinit+0x18d>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102fed:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80102ff3:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102ffa:	00 
80102ffb:	c7 44 24 04 bd 74 10 	movl   $0x801074bd,0x4(%esp)
80103002:	80 
80103003:	89 04 24             	mov    %eax,(%esp)
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103006:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103009:	e8 82 15 00 00       	call   80104590 <memcmp>
8010300e:	85 c0                	test   %eax,%eax
80103010:	0f 85 07 01 00 00    	jne    8010311d <mpinit+0x18d>
  if(conf->version != 1 && conf->version != 4)
80103016:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010301d:	3c 04                	cmp    $0x4,%al
8010301f:	0f 85 0b 01 00 00    	jne    80103130 <mpinit+0x1a0>
  if(sum((uchar*)conf, conf->length) != 0)
80103025:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
  for(i=0; i<len; i++)
8010302c:	85 c0                	test   %eax,%eax
8010302e:	74 21                	je     80103051 <mpinit+0xc1>
  sum = 0;
80103030:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
80103032:	31 d2                	xor    %edx,%edx
80103034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103038:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
8010303f:	80 
  for(i=0; i<len; i++)
80103040:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103043:	01 d9                	add    %ebx,%ecx
  for(i=0; i<len; i++)
80103045:	39 d0                	cmp    %edx,%eax
80103047:	7f ef                	jg     80103038 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103049:	84 c9                	test   %cl,%cl
8010304b:	0f 85 cc 00 00 00    	jne    8010311d <mpinit+0x18d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103051:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103054:	85 c0                	test   %eax,%eax
80103056:	0f 84 c1 00 00 00    	je     8010311d <mpinit+0x18d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010305c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  ismp = 1;
80103062:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
80103067:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010306c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103073:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103079:	03 55 e4             	add    -0x1c(%ebp),%edx
8010307c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103080:	39 c2                	cmp    %eax,%edx
80103082:	76 1b                	jbe    8010309f <mpinit+0x10f>
80103084:	0f b6 08             	movzbl (%eax),%ecx
    switch(*p){
80103087:	80 f9 04             	cmp    $0x4,%cl
8010308a:	77 74                	ja     80103100 <mpinit+0x170>
8010308c:	ff 24 8d fc 74 10 80 	jmp    *-0x7fef8b04(,%ecx,4)
80103093:	90                   	nop
80103094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103098:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010309b:	39 c2                	cmp    %eax,%edx
8010309d:	77 e5                	ja     80103084 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010309f:	85 db                	test   %ebx,%ebx
801030a1:	0f 84 93 00 00 00    	je     8010313a <mpinit+0x1aa>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801030a7:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801030ab:	74 12                	je     801030bf <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030ad:	ba 22 00 00 00       	mov    $0x22,%edx
801030b2:	b8 70 00 00 00       	mov    $0x70,%eax
801030b7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030b8:	b2 23                	mov    $0x23,%dl
801030ba:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801030bb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030be:	ee                   	out    %al,(%dx)
  }
}
801030bf:	83 c4 1c             	add    $0x1c,%esp
801030c2:	5b                   	pop    %ebx
801030c3:	5e                   	pop    %esi
801030c4:	5f                   	pop    %edi
801030c5:	5d                   	pop    %ebp
801030c6:	c3                   	ret    
801030c7:	90                   	nop
      if(ncpu < NCPU) {
801030c8:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801030ce:	83 fe 07             	cmp    $0x7,%esi
801030d1:	7f 17                	jg     801030ea <mpinit+0x15a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801030d3:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
801030d7:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
        ncpu++;
801030dd:	83 05 00 2d 11 80 01 	addl   $0x1,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801030e4:	88 8e 80 27 11 80    	mov    %cl,-0x7feed880(%esi)
      p += sizeof(struct mpproc);
801030ea:	83 c0 14             	add    $0x14,%eax
      continue;
801030ed:	eb 91                	jmp    80103080 <mpinit+0xf0>
801030ef:	90                   	nop
      ioapicid = ioapic->apicno;
801030f0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801030f4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801030f7:	88 0d 60 27 11 80    	mov    %cl,0x80112760
      continue;
801030fd:	eb 81                	jmp    80103080 <mpinit+0xf0>
801030ff:	90                   	nop
      ismp = 0;
80103100:	31 db                	xor    %ebx,%ebx
80103102:	eb 83                	jmp    80103087 <mpinit+0xf7>
  return mpsearch1(0xF0000, 0x10000);
80103104:	ba 00 00 01 00       	mov    $0x10000,%edx
80103109:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010310e:	e8 0d fe ff ff       	call   80102f20 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103113:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103115:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103117:	0f 85 c5 fe ff ff    	jne    80102fe2 <mpinit+0x52>
    panic("Expect to run on an SMP");
8010311d:	c7 04 24 c2 74 10 80 	movl   $0x801074c2,(%esp)
80103124:	e8 37 d2 ff ff       	call   80100360 <panic>
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(conf->version != 1 && conf->version != 4)
80103130:	3c 01                	cmp    $0x1,%al
80103132:	0f 84 ed fe ff ff    	je     80103025 <mpinit+0x95>
80103138:	eb e3                	jmp    8010311d <mpinit+0x18d>
    panic("Didn't find a suitable machine");
8010313a:	c7 04 24 dc 74 10 80 	movl   $0x801074dc,(%esp)
80103141:	e8 1a d2 ff ff       	call   80100360 <panic>
80103146:	66 90                	xchg   %ax,%ax
80103148:	66 90                	xchg   %ax,%ax
8010314a:	66 90                	xchg   %ax,%ax
8010314c:	66 90                	xchg   %ax,%ax
8010314e:	66 90                	xchg   %ax,%ax

80103150 <picinit>:
80103150:	55                   	push   %ebp
80103151:	ba 21 00 00 00       	mov    $0x21,%edx
80103156:	89 e5                	mov    %esp,%ebp
80103158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010315d:	ee                   	out    %al,(%dx)
8010315e:	b2 a1                	mov    $0xa1,%dl
80103160:	ee                   	out    %al,(%dx)
80103161:	5d                   	pop    %ebp
80103162:	c3                   	ret    
80103163:	66 90                	xchg   %ax,%ax
80103165:	66 90                	xchg   %ax,%ax
80103167:	66 90                	xchg   %ax,%ax
80103169:	66 90                	xchg   %ax,%ax
8010316b:	66 90                	xchg   %ax,%ax
8010316d:	66 90                	xchg   %ax,%ax
8010316f:	90                   	nop

80103170 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
80103175:	53                   	push   %ebx
80103176:	83 ec 1c             	sub    $0x1c,%esp
80103179:	8b 75 08             	mov    0x8(%ebp),%esi
8010317c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010317f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103185:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010318b:	e8 e0 db ff ff       	call   80100d70 <filealloc>
80103190:	85 c0                	test   %eax,%eax
80103192:	89 06                	mov    %eax,(%esi)
80103194:	0f 84 a4 00 00 00    	je     8010323e <pipealloc+0xce>
8010319a:	e8 d1 db ff ff       	call   80100d70 <filealloc>
8010319f:	85 c0                	test   %eax,%eax
801031a1:	89 03                	mov    %eax,(%ebx)
801031a3:	0f 84 87 00 00 00    	je     80103230 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801031a9:	e8 f2 f2 ff ff       	call   801024a0 <kalloc>
801031ae:	85 c0                	test   %eax,%eax
801031b0:	89 c7                	mov    %eax,%edi
801031b2:	74 7c                	je     80103230 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
801031b4:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801031bb:	00 00 00 
  p->writeopen = 1;
801031be:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801031c5:	00 00 00 
  p->nwrite = 0;
801031c8:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801031cf:	00 00 00 
  p->nread = 0;
801031d2:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801031d9:	00 00 00 
  initlock(&p->lock, "pipe");
801031dc:	89 04 24             	mov    %eax,(%esp)
801031df:	c7 44 24 04 10 75 10 	movl   $0x80107510,0x4(%esp)
801031e6:	80 
801031e7:	e8 24 11 00 00       	call   80104310 <initlock>
  (*f0)->type = FD_PIPE;
801031ec:	8b 06                	mov    (%esi),%eax
801031ee:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801031f4:	8b 06                	mov    (%esi),%eax
801031f6:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801031fa:	8b 06                	mov    (%esi),%eax
801031fc:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103200:	8b 06                	mov    (%esi),%eax
80103202:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103205:	8b 03                	mov    (%ebx),%eax
80103207:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010320d:	8b 03                	mov    (%ebx),%eax
8010320f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103213:	8b 03                	mov    (%ebx),%eax
80103215:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103219:	8b 03                	mov    (%ebx),%eax
  return 0;
8010321b:	31 db                	xor    %ebx,%ebx
  (*f1)->pipe = p;
8010321d:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103220:	83 c4 1c             	add    $0x1c,%esp
80103223:	89 d8                	mov    %ebx,%eax
80103225:	5b                   	pop    %ebx
80103226:	5e                   	pop    %esi
80103227:	5f                   	pop    %edi
80103228:	5d                   	pop    %ebp
80103229:	c3                   	ret    
8010322a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*f0)
80103230:	8b 06                	mov    (%esi),%eax
80103232:	85 c0                	test   %eax,%eax
80103234:	74 08                	je     8010323e <pipealloc+0xce>
    fileclose(*f0);
80103236:	89 04 24             	mov    %eax,(%esp)
80103239:	e8 f2 db ff ff       	call   80100e30 <fileclose>
  if(*f1)
8010323e:	8b 03                	mov    (%ebx),%eax
  return -1;
80103240:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if(*f1)
80103245:	85 c0                	test   %eax,%eax
80103247:	74 d7                	je     80103220 <pipealloc+0xb0>
    fileclose(*f1);
80103249:	89 04 24             	mov    %eax,(%esp)
8010324c:	e8 df db ff ff       	call   80100e30 <fileclose>
}
80103251:	83 c4 1c             	add    $0x1c,%esp
80103254:	89 d8                	mov    %ebx,%eax
80103256:	5b                   	pop    %ebx
80103257:	5e                   	pop    %esi
80103258:	5f                   	pop    %edi
80103259:	5d                   	pop    %ebp
8010325a:	c3                   	ret    
8010325b:	90                   	nop
8010325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103260 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	56                   	push   %esi
80103264:	53                   	push   %ebx
80103265:	83 ec 10             	sub    $0x10,%esp
80103268:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010326b:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010326e:	89 1c 24             	mov    %ebx,(%esp)
80103271:	e8 0a 12 00 00       	call   80104480 <acquire>
  if(writable){
80103276:	85 f6                	test   %esi,%esi
80103278:	74 3e                	je     801032b8 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->nread);
8010327a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103280:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103287:	00 00 00 
    wakeup(&p->nread);
8010328a:	89 04 24             	mov    %eax,(%esp)
8010328d:	e8 6e 0d 00 00       	call   80104000 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103292:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103298:	85 d2                	test   %edx,%edx
8010329a:	75 0a                	jne    801032a6 <pipeclose+0x46>
8010329c:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801032a2:	85 c0                	test   %eax,%eax
801032a4:	74 32                	je     801032d8 <pipeclose+0x78>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801032a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801032a9:	83 c4 10             	add    $0x10,%esp
801032ac:	5b                   	pop    %ebx
801032ad:	5e                   	pop    %esi
801032ae:	5d                   	pop    %ebp
    release(&p->lock);
801032af:	e9 3c 12 00 00       	jmp    801044f0 <release>
801032b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801032b8:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801032be:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801032c5:	00 00 00 
    wakeup(&p->nwrite);
801032c8:	89 04 24             	mov    %eax,(%esp)
801032cb:	e8 30 0d 00 00       	call   80104000 <wakeup>
801032d0:	eb c0                	jmp    80103292 <pipeclose+0x32>
801032d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&p->lock);
801032d8:	89 1c 24             	mov    %ebx,(%esp)
801032db:	e8 10 12 00 00       	call   801044f0 <release>
    kfree((char*)p);
801032e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801032e3:	83 c4 10             	add    $0x10,%esp
801032e6:	5b                   	pop    %ebx
801032e7:	5e                   	pop    %esi
801032e8:	5d                   	pop    %ebp
    kfree((char*)p);
801032e9:	e9 02 f0 ff ff       	jmp    801022f0 <kfree>
801032ee:	66 90                	xchg   %ax,%ax

801032f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	57                   	push   %edi
801032f4:	56                   	push   %esi
801032f5:	53                   	push   %ebx
801032f6:	83 ec 1c             	sub    $0x1c,%esp
801032f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801032fc:	89 1c 24             	mov    %ebx,(%esp)
801032ff:	e8 7c 11 00 00       	call   80104480 <acquire>
  for(i = 0; i < n; i++){
80103304:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103307:	85 c9                	test   %ecx,%ecx
80103309:	0f 8e b2 00 00 00    	jle    801033c1 <pipewrite+0xd1>
8010330f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103312:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103318:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010331e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103324:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103327:	03 4d 10             	add    0x10(%ebp),%ecx
8010332a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010332d:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103333:	81 c1 00 02 00 00    	add    $0x200,%ecx
80103339:	39 c8                	cmp    %ecx,%eax
8010333b:	74 38                	je     80103375 <pipewrite+0x85>
8010333d:	eb 55                	jmp    80103394 <pipewrite+0xa4>
8010333f:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103340:	e8 ab 03 00 00       	call   801036f0 <myproc>
80103345:	8b 40 24             	mov    0x24(%eax),%eax
80103348:	85 c0                	test   %eax,%eax
8010334a:	75 33                	jne    8010337f <pipewrite+0x8f>
      wakeup(&p->nread);
8010334c:	89 3c 24             	mov    %edi,(%esp)
8010334f:	e8 ac 0c 00 00       	call   80104000 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103354:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103358:	89 34 24             	mov    %esi,(%esp)
8010335b:	e8 f0 09 00 00       	call   80103d50 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103360:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103366:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010336c:	05 00 02 00 00       	add    $0x200,%eax
80103371:	39 c2                	cmp    %eax,%edx
80103373:	75 23                	jne    80103398 <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
80103375:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010337b:	85 d2                	test   %edx,%edx
8010337d:	75 c1                	jne    80103340 <pipewrite+0x50>
        release(&p->lock);
8010337f:	89 1c 24             	mov    %ebx,(%esp)
80103382:	e8 69 11 00 00       	call   801044f0 <release>
        return -1;
80103387:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010338c:	83 c4 1c             	add    $0x1c,%esp
8010338f:	5b                   	pop    %ebx
80103390:	5e                   	pop    %esi
80103391:	5f                   	pop    %edi
80103392:	5d                   	pop    %ebp
80103393:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103394:	89 c2                	mov    %eax,%edx
80103396:	66 90                	xchg   %ax,%ax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103398:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010339b:	8d 42 01             	lea    0x1(%edx),%eax
8010339e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801033a4:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801033aa:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801033ae:	0f b6 09             	movzbl (%ecx),%ecx
801033b1:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801033b5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801033b8:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801033bb:	0f 85 6c ff ff ff    	jne    8010332d <pipewrite+0x3d>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801033c1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033c7:	89 04 24             	mov    %eax,(%esp)
801033ca:	e8 31 0c 00 00       	call   80104000 <wakeup>
  release(&p->lock);
801033cf:	89 1c 24             	mov    %ebx,(%esp)
801033d2:	e8 19 11 00 00       	call   801044f0 <release>
  return n;
801033d7:	8b 45 10             	mov    0x10(%ebp),%eax
801033da:	eb b0                	jmp    8010338c <pipewrite+0x9c>
801033dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801033e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 1c             	sub    $0x1c,%esp
801033e9:	8b 75 08             	mov    0x8(%ebp),%esi
801033ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801033ef:	89 34 24             	mov    %esi,(%esp)
801033f2:	e8 89 10 00 00       	call   80104480 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801033f7:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801033fd:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103403:	75 5b                	jne    80103460 <piperead+0x80>
80103405:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010340b:	85 db                	test   %ebx,%ebx
8010340d:	74 51                	je     80103460 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010340f:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103415:	eb 25                	jmp    8010343c <piperead+0x5c>
80103417:	90                   	nop
80103418:	89 74 24 04          	mov    %esi,0x4(%esp)
8010341c:	89 1c 24             	mov    %ebx,(%esp)
8010341f:	e8 2c 09 00 00       	call   80103d50 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103424:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010342a:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103430:	75 2e                	jne    80103460 <piperead+0x80>
80103432:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103438:	85 d2                	test   %edx,%edx
8010343a:	74 24                	je     80103460 <piperead+0x80>
    if(myproc()->killed){
8010343c:	e8 af 02 00 00       	call   801036f0 <myproc>
80103441:	8b 48 24             	mov    0x24(%eax),%ecx
80103444:	85 c9                	test   %ecx,%ecx
80103446:	74 d0                	je     80103418 <piperead+0x38>
      release(&p->lock);
80103448:	89 34 24             	mov    %esi,(%esp)
8010344b:	e8 a0 10 00 00       	call   801044f0 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103450:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80103453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103458:	5b                   	pop    %ebx
80103459:	5e                   	pop    %esi
8010345a:	5f                   	pop    %edi
8010345b:	5d                   	pop    %ebp
8010345c:	c3                   	ret    
8010345d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103460:	8b 55 10             	mov    0x10(%ebp),%edx
    if(p->nread == p->nwrite)
80103463:	31 db                	xor    %ebx,%ebx
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103465:	85 d2                	test   %edx,%edx
80103467:	7f 2b                	jg     80103494 <piperead+0xb4>
80103469:	eb 31                	jmp    8010349c <piperead+0xbc>
8010346b:	90                   	nop
8010346c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103470:	8d 48 01             	lea    0x1(%eax),%ecx
80103473:	25 ff 01 00 00       	and    $0x1ff,%eax
80103478:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010347e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103483:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103486:	83 c3 01             	add    $0x1,%ebx
80103489:	3b 5d 10             	cmp    0x10(%ebp),%ebx
8010348c:	74 0e                	je     8010349c <piperead+0xbc>
    if(p->nread == p->nwrite)
8010348e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103494:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010349a:	75 d4                	jne    80103470 <piperead+0x90>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010349c:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801034a2:	89 04 24             	mov    %eax,(%esp)
801034a5:	e8 56 0b 00 00       	call   80104000 <wakeup>
  release(&p->lock);
801034aa:	89 34 24             	mov    %esi,(%esp)
801034ad:	e8 3e 10 00 00       	call   801044f0 <release>
}
801034b2:	83 c4 1c             	add    $0x1c,%esp
  return i;
801034b5:	89 d8                	mov    %ebx,%eax
}
801034b7:	5b                   	pop    %ebx
801034b8:	5e                   	pop    %esi
801034b9:	5f                   	pop    %edi
801034ba:	5d                   	pop    %ebp
801034bb:	c3                   	ret    
801034bc:	66 90                	xchg   %ax,%ax
801034be:	66 90                	xchg   %ax,%ax

801034c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801034c4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801034c9:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
801034cc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801034d3:	e8 a8 0f 00 00       	call   80104480 <acquire>
801034d8:	eb 18                	jmp    801034f2 <allocproc+0x32>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801034e0:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801034e6:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
801034ec:	0f 84 c6 00 00 00    	je     801035b8 <allocproc+0xf8>
    if(p->state == UNUSED)
801034f2:	8b 43 0c             	mov    0xc(%ebx),%eax
801034f5:	85 c0                	test   %eax,%eax
801034f7:	75 e7                	jne    801034e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801034f9:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  //p->prior_val = 15; //createsa default priority value if not specified (lab2)

  release(&ptable.lock);
801034fe:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  p->state = EMBRYO;
80103505:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
8010350c:	8d 50 01             	lea    0x1(%eax),%edx
8010350f:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
80103515:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103518:	e8 d3 0f 00 00       	call   801044f0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010351d:	e8 7e ef ff ff       	call   801024a0 <kalloc>
80103522:	85 c0                	test   %eax,%eax
80103524:	89 43 08             	mov    %eax,0x8(%ebx)
80103527:	0f 84 9f 00 00 00    	je     801035cc <allocproc+0x10c>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010352d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103533:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103538:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010353b:	c7 40 14 a5 57 10 80 	movl   $0x801057a5,0x14(%eax)
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103542:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80103549:	00 
8010354a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103551:	00 
80103552:	89 04 24             	mov    %eax,(%esp)
  p->context = (struct context*)sp;
80103555:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103558:	e8 e3 0f 00 00       	call   80104540 <memset>
  p->context->eip = (uint)forkret;
8010355d:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103560:	c7 40 10 e0 35 10 80 	movl   $0x801035e0,0x10(%eax)
/*------------------New section for time (lab2)--------------------------*/
	acquire(&ptable.lock);
80103567:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010356e:	e8 0d 0f 00 00       	call   80104480 <acquire>
	p->start_time = ticks;
80103573:	a1 a0 58 11 80       	mov    0x801158a0,%eax
	release(&ptable.lock);
80103578:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
	p->start_time = ticks;
8010357f:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
	release(&ptable.lock);
80103585:	e8 66 0f 00 00       	call   801044f0 <release>
	cprintf("start time: %d\n", p->start_time);
8010358a:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80103590:	c7 04 24 15 75 10 80 	movl   $0x80107515,(%esp)
80103597:	89 44 24 04          	mov    %eax,0x4(%esp)
8010359b:	e8 b0 d0 ff ff       	call   80100650 <cprintf>
	p->end_time = 0;
/*-------------------------end-------------------------------------------*/
  return p;
801035a0:	89 d8                	mov    %ebx,%eax
	p->end_time = 0;
801035a2:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801035a9:	00 00 00 
}
801035ac:	83 c4 14             	add    $0x14,%esp
801035af:	5b                   	pop    %ebx
801035b0:	5d                   	pop    %ebp
801035b1:	c3                   	ret    
801035b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801035b8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035bf:	e8 2c 0f 00 00       	call   801044f0 <release>
}
801035c4:	83 c4 14             	add    $0x14,%esp
  return 0;
801035c7:	31 c0                	xor    %eax,%eax
}
801035c9:	5b                   	pop    %ebx
801035ca:	5d                   	pop    %ebp
801035cb:	c3                   	ret    
    p->state = UNUSED;
801035cc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801035d3:	eb d7                	jmp    801035ac <allocproc+0xec>
801035d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801035e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801035e6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035ed:	e8 fe 0e 00 00       	call   801044f0 <release>

  if (first) {
801035f2:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801035f7:	85 c0                	test   %eax,%eax
801035f9:	75 05                	jne    80103600 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801035fb:	c9                   	leave  
801035fc:	c3                   	ret    
801035fd:	8d 76 00             	lea    0x0(%esi),%esi
    iinit(ROOTDEV);
80103600:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
80103607:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010360e:	00 00 00 
    iinit(ROOTDEV);
80103611:	e8 5a de ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
80103616:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010361d:	e8 4e f4 ff ff       	call   80102a70 <initlog>
}
80103622:	c9                   	leave  
80103623:	c3                   	ret    
80103624:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010362a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103630 <pinit>:
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103636:	c7 44 24 04 25 75 10 	movl   $0x80107525,0x4(%esp)
8010363d:	80 
8010363e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103645:	e8 c6 0c 00 00       	call   80104310 <initlock>
}
8010364a:	c9                   	leave  
8010364b:	c3                   	ret    
8010364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103650 <mycpu>:
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	56                   	push   %esi
80103654:	53                   	push   %ebx
80103655:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103658:	9c                   	pushf  
80103659:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010365a:	f6 c4 02             	test   $0x2,%ah
8010365d:	75 57                	jne    801036b6 <mycpu+0x66>
  apicid = lapicid();
8010365f:	e8 fc f0 ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103664:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
8010366a:	85 f6                	test   %esi,%esi
8010366c:	7e 3c                	jle    801036aa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010366e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103675:	39 c2                	cmp    %eax,%edx
80103677:	74 2d                	je     801036a6 <mycpu+0x56>
80103679:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010367e:	31 d2                	xor    %edx,%edx
80103680:	83 c2 01             	add    $0x1,%edx
80103683:	39 f2                	cmp    %esi,%edx
80103685:	74 23                	je     801036aa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103687:	0f b6 19             	movzbl (%ecx),%ebx
8010368a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103690:	39 c3                	cmp    %eax,%ebx
80103692:	75 ec                	jne    80103680 <mycpu+0x30>
      return &cpus[i];
80103694:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
}
8010369a:	83 c4 10             	add    $0x10,%esp
8010369d:	5b                   	pop    %ebx
8010369e:	5e                   	pop    %esi
8010369f:	5d                   	pop    %ebp
      return &cpus[i];
801036a0:	05 80 27 11 80       	add    $0x80112780,%eax
}
801036a5:	c3                   	ret    
  for (i = 0; i < ncpu; ++i) {
801036a6:	31 d2                	xor    %edx,%edx
801036a8:	eb ea                	jmp    80103694 <mycpu+0x44>
  panic("unknown apicid\n");
801036aa:	c7 04 24 2c 75 10 80 	movl   $0x8010752c,(%esp)
801036b1:	e8 aa cc ff ff       	call   80100360 <panic>
    panic("mycpu called with interrupts enabled\n");
801036b6:	c7 04 24 2c 76 10 80 	movl   $0x8010762c,(%esp)
801036bd:	e8 9e cc ff ff       	call   80100360 <panic>
801036c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036d0 <cpuid>:
cpuid() {
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801036d6:	e8 75 ff ff ff       	call   80103650 <mycpu>
}
801036db:	c9                   	leave  
  return mycpu()-cpus;
801036dc:	2d 80 27 11 80       	sub    $0x80112780,%eax
801036e1:	c1 f8 04             	sar    $0x4,%eax
801036e4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801036ea:	c3                   	ret    
801036eb:	90                   	nop
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036f0 <myproc>:
myproc(void) {
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	53                   	push   %ebx
801036f4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801036f7:	e8 94 0c 00 00       	call   80104390 <pushcli>
  c = mycpu();
801036fc:	e8 4f ff ff ff       	call   80103650 <mycpu>
  p = c->proc;
80103701:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103707:	e8 c4 0c 00 00       	call   801043d0 <popcli>
}
8010370c:	83 c4 04             	add    $0x4,%esp
8010370f:	89 d8                	mov    %ebx,%eax
80103711:	5b                   	pop    %ebx
80103712:	5d                   	pop    %ebp
80103713:	c3                   	ret    
80103714:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010371a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103720 <userinit>:
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	53                   	push   %ebx
80103724:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
80103727:	e8 94 fd ff ff       	call   801034c0 <allocproc>
8010372c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010372e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103733:	e8 e8 35 00 00       	call   80106d20 <setupkvm>
80103738:	85 c0                	test   %eax,%eax
8010373a:	89 43 04             	mov    %eax,0x4(%ebx)
8010373d:	0f 84 d4 00 00 00    	je     80103817 <userinit+0xf7>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103743:	89 04 24             	mov    %eax,(%esp)
80103746:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
8010374d:	00 
8010374e:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103755:	80 
80103756:	e8 f5 32 00 00       	call   80106a50 <inituvm>
  p->sz = PGSIZE;
8010375b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103761:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103768:	00 
80103769:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103770:	00 
80103771:	8b 43 18             	mov    0x18(%ebx),%eax
80103774:	89 04 24             	mov    %eax,(%esp)
80103777:	e8 c4 0d 00 00       	call   80104540 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010377c:	8b 43 18             	mov    0x18(%ebx),%eax
8010377f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103784:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103789:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010378d:	8b 43 18             	mov    0x18(%ebx),%eax
80103790:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103794:	8b 43 18             	mov    0x18(%ebx),%eax
80103797:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010379b:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010379f:	8b 43 18             	mov    0x18(%ebx),%eax
801037a2:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801037a6:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801037aa:	8b 43 18             	mov    0x18(%ebx),%eax
801037ad:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801037b4:	8b 43 18             	mov    0x18(%ebx),%eax
801037b7:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801037be:	8b 43 18             	mov    0x18(%ebx),%eax
801037c1:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801037c8:	8d 43 6c             	lea    0x6c(%ebx),%eax
801037cb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801037d2:	00 
801037d3:	c7 44 24 04 55 75 10 	movl   $0x80107555,0x4(%esp)
801037da:	80 
801037db:	89 04 24             	mov    %eax,(%esp)
801037de:	e8 3d 0f 00 00       	call   80104720 <safestrcpy>
  p->cwd = namei("/");
801037e3:	c7 04 24 5e 75 10 80 	movl   $0x8010755e,(%esp)
801037ea:	e8 11 e7 ff ff       	call   80101f00 <namei>
801037ef:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801037f2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801037f9:	e8 82 0c 00 00       	call   80104480 <acquire>
  p->state = RUNNABLE;
801037fe:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103805:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010380c:	e8 df 0c 00 00       	call   801044f0 <release>
}
80103811:	83 c4 14             	add    $0x14,%esp
80103814:	5b                   	pop    %ebx
80103815:	5d                   	pop    %ebp
80103816:	c3                   	ret    
    panic("userinit: out of memory?");
80103817:	c7 04 24 3c 75 10 80 	movl   $0x8010753c,(%esp)
8010381e:	e8 3d cb ff ff       	call   80100360 <panic>
80103823:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103830 <growproc>:
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	56                   	push   %esi
80103834:	53                   	push   %ebx
80103835:	83 ec 10             	sub    $0x10,%esp
80103838:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *curproc = myproc();
8010383b:	e8 b0 fe ff ff       	call   801036f0 <myproc>
  if(n > 0){
80103840:	83 fe 00             	cmp    $0x0,%esi
  struct proc *curproc = myproc();
80103843:	89 c3                	mov    %eax,%ebx
  sz = curproc->sz;
80103845:	8b 00                	mov    (%eax),%eax
  if(n > 0){
80103847:	7e 2f                	jle    80103878 <growproc+0x48>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103849:	01 c6                	add    %eax,%esi
8010384b:	89 74 24 08          	mov    %esi,0x8(%esp)
8010384f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103853:	8b 43 04             	mov    0x4(%ebx),%eax
80103856:	89 04 24             	mov    %eax,(%esp)
80103859:	e8 32 33 00 00       	call   80106b90 <allocuvm>
8010385e:	85 c0                	test   %eax,%eax
80103860:	74 36                	je     80103898 <growproc+0x68>
  curproc->sz = sz;
80103862:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103864:	89 1c 24             	mov    %ebx,(%esp)
80103867:	e8 d4 30 00 00       	call   80106940 <switchuvm>
  return 0;
8010386c:	31 c0                	xor    %eax,%eax
}
8010386e:	83 c4 10             	add    $0x10,%esp
80103871:	5b                   	pop    %ebx
80103872:	5e                   	pop    %esi
80103873:	5d                   	pop    %ebp
80103874:	c3                   	ret    
80103875:	8d 76 00             	lea    0x0(%esi),%esi
  } else if(n < 0){
80103878:	74 e8                	je     80103862 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010387a:	01 c6                	add    %eax,%esi
8010387c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103880:	89 44 24 04          	mov    %eax,0x4(%esp)
80103884:	8b 43 04             	mov    0x4(%ebx),%eax
80103887:	89 04 24             	mov    %eax,(%esp)
8010388a:	e8 f1 33 00 00       	call   80106c80 <deallocuvm>
8010388f:	85 c0                	test   %eax,%eax
80103891:	75 cf                	jne    80103862 <growproc+0x32>
80103893:	90                   	nop
80103894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80103898:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010389d:	eb cf                	jmp    8010386e <growproc+0x3e>
8010389f:	90                   	nop

801038a0 <fork>:
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	57                   	push   %edi
801038a4:	56                   	push   %esi
801038a5:	53                   	push   %ebx
801038a6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = myproc();
801038a9:	e8 42 fe ff ff       	call   801036f0 <myproc>
801038ae:	89 c3                	mov    %eax,%ebx
  if((np = allocproc()) == 0){
801038b0:	e8 0b fc ff ff       	call   801034c0 <allocproc>
801038b5:	85 c0                	test   %eax,%eax
801038b7:	89 c7                	mov    %eax,%edi
801038b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801038bc:	0f 84 bc 00 00 00    	je     8010397e <fork+0xde>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801038c2:	8b 03                	mov    (%ebx),%eax
801038c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801038c8:	8b 43 04             	mov    0x4(%ebx),%eax
801038cb:	89 04 24             	mov    %eax,(%esp)
801038ce:	e8 2d 35 00 00       	call   80106e00 <copyuvm>
801038d3:	85 c0                	test   %eax,%eax
801038d5:	89 47 04             	mov    %eax,0x4(%edi)
801038d8:	0f 84 a7 00 00 00    	je     80103985 <fork+0xe5>
  np->sz = curproc->sz;
801038de:	8b 03                	mov    (%ebx),%eax
801038e0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801038e3:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
801038e5:	8b 79 18             	mov    0x18(%ecx),%edi
801038e8:	89 c8                	mov    %ecx,%eax
  np->parent = curproc;
801038ea:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801038ed:	8b 73 18             	mov    0x18(%ebx),%esi
801038f0:	b9 13 00 00 00       	mov    $0x13,%ecx
801038f5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801038f7:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801038f9:	8b 40 18             	mov    0x18(%eax),%eax
801038fc:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103903:	90                   	nop
80103904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103908:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010390c:	85 c0                	test   %eax,%eax
8010390e:	74 0f                	je     8010391f <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103910:	89 04 24             	mov    %eax,(%esp)
80103913:	e8 c8 d4 ff ff       	call   80100de0 <filedup>
80103918:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010391b:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010391f:	83 c6 01             	add    $0x1,%esi
80103922:	83 fe 10             	cmp    $0x10,%esi
80103925:	75 e1                	jne    80103908 <fork+0x68>
  np->cwd = idup(curproc->cwd);
80103927:	8b 43 68             	mov    0x68(%ebx),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010392a:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010392d:	89 04 24             	mov    %eax,(%esp)
80103930:	e8 4b dd ff ff       	call   80101680 <idup>
80103935:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103938:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010393b:	8d 47 6c             	lea    0x6c(%edi),%eax
8010393e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103942:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103949:	00 
8010394a:	89 04 24             	mov    %eax,(%esp)
8010394d:	e8 ce 0d 00 00       	call   80104720 <safestrcpy>
  pid = np->pid;
80103952:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103955:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010395c:	e8 1f 0b 00 00       	call   80104480 <acquire>
  np->state = RUNNABLE;
80103961:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103968:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010396f:	e8 7c 0b 00 00       	call   801044f0 <release>
  return pid;
80103974:	89 d8                	mov    %ebx,%eax
}
80103976:	83 c4 1c             	add    $0x1c,%esp
80103979:	5b                   	pop    %ebx
8010397a:	5e                   	pop    %esi
8010397b:	5f                   	pop    %edi
8010397c:	5d                   	pop    %ebp
8010397d:	c3                   	ret    
    return -1;
8010397e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103983:	eb f1                	jmp    80103976 <fork+0xd6>
    kfree(np->kstack);
80103985:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103988:	8b 47 08             	mov    0x8(%edi),%eax
8010398b:	89 04 24             	mov    %eax,(%esp)
8010398e:	e8 5d e9 ff ff       	call   801022f0 <kfree>
    return -1;
80103993:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    np->kstack = 0;
80103998:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
8010399f:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
801039a6:	eb ce                	jmp    80103976 <fork+0xd6>
801039a8:	90                   	nop
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039b0 <scheduler>:
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	57                   	push   %edi
801039b4:	56                   	push   %esi
801039b5:	53                   	push   %ebx
801039b6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
801039b9:	e8 92 fc ff ff       	call   80103650 <mycpu>
801039be:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
801039c0:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801039c7:	00 00 00 
801039ca:	8d 70 04             	lea    0x4(%eax),%esi
  asm volatile("sti");
801039cd:	fb                   	sti    
    acquire(&ptable.lock);
801039ce:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039d5:	bf 54 2d 11 80       	mov    $0x80112d54,%edi
    acquire(&ptable.lock);
801039da:	e8 a1 0a 00 00       	call   80104480 <acquire>
801039df:	eb 19                	jmp    801039fa <scheduler+0x4a>
801039e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039e8:	81 c7 8c 00 00 00    	add    $0x8c,%edi
801039ee:	81 ff 54 50 11 80    	cmp    $0x80115054,%edi
801039f4:	0f 83 84 00 00 00    	jae    80103a7e <scheduler+0xce>
      if(p->state != RUNNABLE)
801039fa:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
801039fe:	75 e8                	jne    801039e8 <scheduler+0x38>
80103a00:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103a05:	eb 0f                	jmp    80103a16 <scheduler+0x66>
80103a07:	90                   	nop
        for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){ //iterate through other tracked process (lab2)
80103a08:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103a0e:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103a14:	74 23                	je     80103a39 <scheduler+0x89>
      	   if(p1->state != RUNNABLE)
80103a16:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80103a1a:	75 ec                	jne    80103a08 <scheduler+0x58>
80103a1c:	8b 82 80 00 00 00    	mov    0x80(%edx),%eax
80103a22:	39 87 80 00 00 00    	cmp    %eax,0x80(%edi)
80103a28:	0f 4f fa             	cmovg  %edx,%edi
        for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){ //iterate through other tracked process (lab2)
80103a2b:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103a31:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103a37:	75 dd                	jne    80103a16 <scheduler+0x66>
      c->proc = p;
80103a39:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103a3f:	89 3c 24             	mov    %edi,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a42:	81 c7 8c 00 00 00    	add    $0x8c,%edi
      switchuvm(p);
80103a48:	e8 f3 2e 00 00       	call   80106940 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103a4d:	8b 47 90             	mov    -0x70(%edi),%eax
      p->state = RUNNING;
80103a50:	c7 47 80 04 00 00 00 	movl   $0x4,-0x80(%edi)
      swtch(&(c->scheduler), p->context);
80103a57:	89 34 24             	mov    %esi,(%esp)
80103a5a:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a5e:	e8 18 0d 00 00       	call   8010477b <swtch>
      switchkvm();
80103a63:	e8 b8 2e 00 00       	call   80106920 <switchkvm>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a68:	81 ff 54 50 11 80    	cmp    $0x80115054,%edi
      c->proc = 0;
80103a6e:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103a75:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a78:	0f 82 7c ff ff ff    	jb     801039fa <scheduler+0x4a>
    release(&ptable.lock);
80103a7e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a85:	e8 66 0a 00 00       	call   801044f0 <release>
  }
80103a8a:	e9 3e ff ff ff       	jmp    801039cd <scheduler+0x1d>
80103a8f:	90                   	nop

80103a90 <set_prior>:
set_prior(int prior_lvl) { // sets process priority (lab2)
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	53                   	push   %ebx
80103a94:	83 ec 04             	sub    $0x4,%esp
80103a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc* p = myproc();
80103a9a:	e8 51 fc ff ff       	call   801036f0 <myproc>
	for(p = ptable.proc; p< &ptable.proc[NPROC]; p++) {
80103a9f:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103aa4:	eb 1f                	jmp    80103ac5 <set_prior+0x35>
80103aa6:	66 90                	xchg   %ax,%ax
		else if(prior_lvl > 31) { //priority levels should range from 1 to 31
80103aa8:	83 fb 1f             	cmp    $0x1f,%ebx
80103aab:	7e 43                	jle    80103af0 <set_prior+0x60>
			p->prior_val = 31;
80103aad:	c7 82 80 00 00 00 1f 	movl   $0x1f,0x80(%edx)
80103ab4:	00 00 00 
	for(p = ptable.proc; p< &ptable.proc[NPROC]; p++) {
80103ab7:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103abd:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103ac3:	74 1c                	je     80103ae1 <set_prior+0x51>
		if(prior_lvl < 0) {
80103ac5:	85 db                	test   %ebx,%ebx
80103ac7:	79 df                	jns    80103aa8 <set_prior+0x18>
			p->prior_val = 0;
80103ac9:	c7 82 80 00 00 00 00 	movl   $0x0,0x80(%edx)
80103ad0:	00 00 00 
	for(p = ptable.proc; p< &ptable.proc[NPROC]; p++) {
80103ad3:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103ad9:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103adf:	75 e4                	jne    80103ac5 <set_prior+0x35>
}
80103ae1:	83 c4 04             	add    $0x4,%esp
80103ae4:	89 d8                	mov    %ebx,%eax
80103ae6:	5b                   	pop    %ebx
80103ae7:	5d                   	pop    %ebp
80103ae8:	c3                   	ret    
80103ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			p->prior_val = prior_lvl; //set prior_val from proc.h to new prior_lvl inputed
80103af0:	89 9a 80 00 00 00    	mov    %ebx,0x80(%edx)
}
80103af6:	83 c4 04             	add    $0x4,%esp
80103af9:	89 d8                	mov    %ebx,%eax
80103afb:	5b                   	pop    %ebx
80103afc:	5d                   	pop    %ebp
80103afd:	c3                   	ret    
80103afe:	66 90                	xchg   %ax,%ax

80103b00 <sched>:
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	56                   	push   %esi
80103b04:	53                   	push   %ebx
80103b05:	83 ec 10             	sub    $0x10,%esp
  struct proc *p = myproc();
80103b08:	e8 e3 fb ff ff       	call   801036f0 <myproc>
  if(!holding(&ptable.lock))
80103b0d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  struct proc *p = myproc();
80103b14:	89 c3                	mov    %eax,%ebx
  if(!holding(&ptable.lock))
80103b16:	e8 25 09 00 00       	call   80104440 <holding>
80103b1b:	85 c0                	test   %eax,%eax
80103b1d:	74 4f                	je     80103b6e <sched+0x6e>
  if(mycpu()->ncli != 1)
80103b1f:	e8 2c fb ff ff       	call   80103650 <mycpu>
80103b24:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b2b:	75 65                	jne    80103b92 <sched+0x92>
  if(p->state == RUNNING)
80103b2d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b31:	74 53                	je     80103b86 <sched+0x86>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b33:	9c                   	pushf  
80103b34:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b35:	f6 c4 02             	test   $0x2,%ah
80103b38:	75 40                	jne    80103b7a <sched+0x7a>
  intena = mycpu()->intena;
80103b3a:	e8 11 fb ff ff       	call   80103650 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b3f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103b42:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b48:	e8 03 fb ff ff       	call   80103650 <mycpu>
80103b4d:	8b 40 04             	mov    0x4(%eax),%eax
80103b50:	89 1c 24             	mov    %ebx,(%esp)
80103b53:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b57:	e8 1f 0c 00 00       	call   8010477b <swtch>
  mycpu()->intena = intena;
80103b5c:	e8 ef fa ff ff       	call   80103650 <mycpu>
80103b61:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103b67:	83 c4 10             	add    $0x10,%esp
80103b6a:	5b                   	pop    %ebx
80103b6b:	5e                   	pop    %esi
80103b6c:	5d                   	pop    %ebp
80103b6d:	c3                   	ret    
    panic("sched ptable.lock");
80103b6e:	c7 04 24 60 75 10 80 	movl   $0x80107560,(%esp)
80103b75:	e8 e6 c7 ff ff       	call   80100360 <panic>
    panic("sched interruptible");
80103b7a:	c7 04 24 8c 75 10 80 	movl   $0x8010758c,(%esp)
80103b81:	e8 da c7 ff ff       	call   80100360 <panic>
    panic("sched running");
80103b86:	c7 04 24 7e 75 10 80 	movl   $0x8010757e,(%esp)
80103b8d:	e8 ce c7 ff ff       	call   80100360 <panic>
    panic("sched locks");
80103b92:	c7 04 24 72 75 10 80 	movl   $0x80107572,(%esp)
80103b99:	e8 c2 c7 ff ff       	call   80100360 <panic>
80103b9e:	66 90                	xchg   %ax,%ax

80103ba0 <exit>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	56                   	push   %esi
80103ba4:	53                   	push   %ebx
80103ba5:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103ba8:	e8 43 fb ff ff       	call   801036f0 <myproc>
  if(curproc == initproc)
80103bad:	3b 05 b8 a5 10 80    	cmp    0x8010a5b8,%eax
  struct proc *curproc = myproc();
80103bb3:	89 c3                	mov    %eax,%ebx
  if(curproc == initproc)
80103bb5:	0f 84 3e 01 00 00    	je     80103cf9 <exit+0x159>
	curproc->exitStatus = status; // current process status becomes exit status
80103bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  for(fd = 0; fd < NOFILE; fd++){
80103bbe:	31 f6                	xor    %esi,%esi
	curproc->exitStatus = status; // current process status becomes exit status
80103bc0:	89 43 7c             	mov    %eax,0x7c(%ebx)
80103bc3:	90                   	nop
80103bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80103bc8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103bcc:	85 c0                	test   %eax,%eax
80103bce:	74 10                	je     80103be0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103bd0:	89 04 24             	mov    %eax,(%esp)
80103bd3:	e8 58 d2 ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103bd8:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103bdf:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103be0:	83 c6 01             	add    $0x1,%esi
80103be3:	83 fe 10             	cmp    $0x10,%esi
80103be6:	75 e0                	jne    80103bc8 <exit+0x28>
  begin_op();
80103be8:	e8 23 ef ff ff       	call   80102b10 <begin_op>
  iput(curproc->cwd);
80103bed:	8b 43 68             	mov    0x68(%ebx),%eax
80103bf0:	89 04 24             	mov    %eax,(%esp)
80103bf3:	e8 d8 db ff ff       	call   801017d0 <iput>
  end_op();
80103bf8:	e8 83 ef ff ff       	call   80102b80 <end_op>
  curproc->cwd = 0;
80103bfd:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103c04:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c0b:	e8 70 08 00 00       	call   80104480 <acquire>
  wakeup1(curproc->parent);
80103c10:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c13:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103c18:	eb 14                	jmp    80103c2e <exit+0x8e>
80103c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c20:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103c26:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103c2c:	74 20                	je     80103c4e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103c2e:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c32:	75 ec                	jne    80103c20 <exit+0x80>
80103c34:	3b 42 20             	cmp    0x20(%edx),%eax
80103c37:	75 e7                	jne    80103c20 <exit+0x80>
      p->state = RUNNABLE;
80103c39:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c40:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103c46:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103c4c:	75 e0                	jne    80103c2e <exit+0x8e>
      p->parent = initproc;
80103c4e:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80103c53:	b9 54 2d 11 80       	mov    $0x80112d54,%ecx
80103c58:	eb 14                	jmp    80103c6e <exit+0xce>
80103c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c60:	81 c1 8c 00 00 00    	add    $0x8c,%ecx
80103c66:	81 f9 54 50 11 80    	cmp    $0x80115054,%ecx
80103c6c:	74 3c                	je     80103caa <exit+0x10a>
    if(p->parent == curproc){
80103c6e:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103c71:	75 ed                	jne    80103c60 <exit+0xc0>
      if(p->state == ZOMBIE)
80103c73:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
      p->parent = initproc;
80103c77:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103c7a:	75 e4                	jne    80103c60 <exit+0xc0>
80103c7c:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103c81:	eb 13                	jmp    80103c96 <exit+0xf6>
80103c83:	90                   	nop
80103c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c88:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103c8e:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103c94:	74 ca                	je     80103c60 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103c96:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c9a:	75 ec                	jne    80103c88 <exit+0xe8>
80103c9c:	3b 42 20             	cmp    0x20(%edx),%eax
80103c9f:	75 e7                	jne    80103c88 <exit+0xe8>
      p->state = RUNNABLE;
80103ca1:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103ca8:	eb de                	jmp    80103c88 <exit+0xe8>
	curproc->end_time = ticks;
80103caa:	a1 a0 58 11 80       	mov    0x801158a0,%eax
  curproc->state = ZOMBIE;
80103caf:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
	curproc->end_time = ticks;
80103cb6:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
	cprintf("end time: %d \n", curproc->end_time);
80103cbc:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cc0:	c7 04 24 ad 75 10 80 	movl   $0x801075ad,(%esp)
80103cc7:	e8 84 c9 ff ff       	call   80100650 <cprintf>
	int turn_time = curproc->end_time - curproc->start_time;
80103ccc:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80103cd2:	2b 83 84 00 00 00    	sub    0x84(%ebx),%eax
	cprintf("turnaround time: %d \n", turn_time);
80103cd8:	c7 04 24 bc 75 10 80 	movl   $0x801075bc,(%esp)
80103cdf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ce3:	e8 68 c9 ff ff       	call   80100650 <cprintf>
  sched();
80103ce8:	e8 13 fe ff ff       	call   80103b00 <sched>
  panic("zombie exit");
80103ced:	c7 04 24 d2 75 10 80 	movl   $0x801075d2,(%esp)
80103cf4:	e8 67 c6 ff ff       	call   80100360 <panic>
    panic("init exiting");
80103cf9:	c7 04 24 a0 75 10 80 	movl   $0x801075a0,(%esp)
80103d00:	e8 5b c6 ff ff       	call   80100360 <panic>
80103d05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d10 <yield>:
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d16:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d1d:	e8 5e 07 00 00       	call   80104480 <acquire>
  myproc()->state = RUNNABLE;
80103d22:	e8 c9 f9 ff ff       	call   801036f0 <myproc>
80103d27:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103d2e:	e8 cd fd ff ff       	call   80103b00 <sched>
  release(&ptable.lock);
80103d33:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d3a:	e8 b1 07 00 00       	call   801044f0 <release>
}
80103d3f:	c9                   	leave  
80103d40:	c3                   	ret    
80103d41:	eb 0d                	jmp    80103d50 <sleep>
80103d43:	90                   	nop
80103d44:	90                   	nop
80103d45:	90                   	nop
80103d46:	90                   	nop
80103d47:	90                   	nop
80103d48:	90                   	nop
80103d49:	90                   	nop
80103d4a:	90                   	nop
80103d4b:	90                   	nop
80103d4c:	90                   	nop
80103d4d:	90                   	nop
80103d4e:	90                   	nop
80103d4f:	90                   	nop

80103d50 <sleep>:
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	57                   	push   %edi
80103d54:	56                   	push   %esi
80103d55:	53                   	push   %ebx
80103d56:	83 ec 1c             	sub    $0x1c,%esp
80103d59:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d5c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103d5f:	e8 8c f9 ff ff       	call   801036f0 <myproc>
  if(p == 0)
80103d64:	85 c0                	test   %eax,%eax
  struct proc *p = myproc();
80103d66:	89 c3                	mov    %eax,%ebx
  if(p == 0)
80103d68:	0f 84 7c 00 00 00    	je     80103dea <sleep+0x9a>
  if(lk == 0)
80103d6e:	85 f6                	test   %esi,%esi
80103d70:	74 6c                	je     80103dde <sleep+0x8e>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103d72:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103d78:	74 46                	je     80103dc0 <sleep+0x70>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103d7a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d81:	e8 fa 06 00 00       	call   80104480 <acquire>
    release(lk);
80103d86:	89 34 24             	mov    %esi,(%esp)
80103d89:	e8 62 07 00 00       	call   801044f0 <release>
  p->chan = chan;
80103d8e:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103d91:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103d98:	e8 63 fd ff ff       	call   80103b00 <sched>
  p->chan = 0;
80103d9d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103da4:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103dab:	e8 40 07 00 00       	call   801044f0 <release>
    acquire(lk);
80103db0:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103db3:	83 c4 1c             	add    $0x1c,%esp
80103db6:	5b                   	pop    %ebx
80103db7:	5e                   	pop    %esi
80103db8:	5f                   	pop    %edi
80103db9:	5d                   	pop    %ebp
    acquire(lk);
80103dba:	e9 c1 06 00 00       	jmp    80104480 <acquire>
80103dbf:	90                   	nop
  p->chan = chan;
80103dc0:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103dc3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103dca:	e8 31 fd ff ff       	call   80103b00 <sched>
  p->chan = 0;
80103dcf:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103dd6:	83 c4 1c             	add    $0x1c,%esp
80103dd9:	5b                   	pop    %ebx
80103dda:	5e                   	pop    %esi
80103ddb:	5f                   	pop    %edi
80103ddc:	5d                   	pop    %ebp
80103ddd:	c3                   	ret    
    panic("sleep without lk");
80103dde:	c7 04 24 e4 75 10 80 	movl   $0x801075e4,(%esp)
80103de5:	e8 76 c5 ff ff       	call   80100360 <panic>
    panic("sleep");
80103dea:	c7 04 24 de 75 10 80 	movl   $0x801075de,(%esp)
80103df1:	e8 6a c5 ff ff       	call   80100360 <panic>
80103df6:	8d 76 00             	lea    0x0(%esi),%esi
80103df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e00 <wait>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	57                   	push   %edi
80103e04:	56                   	push   %esi
80103e05:	53                   	push   %ebx
80103e06:	83 ec 1c             	sub    $0x1c,%esp
80103e09:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct proc *curproc = myproc();
80103e0c:	e8 df f8 ff ff       	call   801036f0 <myproc>
  acquire(&ptable.lock);
80103e11:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  struct proc *curproc = myproc();
80103e18:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
80103e1a:	e8 61 06 00 00       	call   80104480 <acquire>
    havekids = 0;
80103e1f:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e21:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103e26:	eb 0e                	jmp    80103e36 <wait+0x36>
80103e28:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103e2e:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103e34:	74 22                	je     80103e58 <wait+0x58>
      if(p->parent != curproc)
80103e36:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e39:	75 ed                	jne    80103e28 <wait+0x28>
      if(p->state == ZOMBIE){
80103e3b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e3f:	74 34                	je     80103e75 <wait+0x75>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e41:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
80103e47:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e4c:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103e52:	75 e2                	jne    80103e36 <wait+0x36>
80103e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(!havekids || curproc->killed){
80103e58:	85 c0                	test   %eax,%eax
80103e5a:	74 78                	je     80103ed4 <wait+0xd4>
80103e5c:	8b 46 24             	mov    0x24(%esi),%eax
80103e5f:	85 c0                	test   %eax,%eax
80103e61:	75 71                	jne    80103ed4 <wait+0xd4>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103e63:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103e6a:	80 
80103e6b:	89 34 24             	mov    %esi,(%esp)
80103e6e:	e8 dd fe ff ff       	call   80103d50 <sleep>
  }
80103e73:	eb aa                	jmp    80103e1f <wait+0x1f>
        kfree(p->kstack);
80103e75:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80103e78:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103e7b:	89 04 24             	mov    %eax,(%esp)
80103e7e:	e8 6d e4 ff ff       	call   801022f0 <kfree>
        freevm(p->pgdir);
80103e83:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80103e86:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103e8d:	89 04 24             	mov    %eax,(%esp)
80103e90:	e8 0b 2e 00 00       	call   80106ca0 <freevm>
	if(status != 0) {
80103e95:	85 ff                	test   %edi,%edi
        p->pid = 0;
80103e97:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103e9e:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103ea5:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103ea9:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103eb0:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
	if(status != 0) {
80103eb7:	74 05                	je     80103ebe <wait+0xbe>
		*status = p->exitStatus;
80103eb9:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103ebc:	89 07                	mov    %eax,(%edi)
        release(&ptable.lock);
80103ebe:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ec5:	e8 26 06 00 00       	call   801044f0 <release>
}
80103eca:	83 c4 1c             	add    $0x1c,%esp
        return pid;
80103ecd:	89 f0                	mov    %esi,%eax
}
80103ecf:	5b                   	pop    %ebx
80103ed0:	5e                   	pop    %esi
80103ed1:	5f                   	pop    %edi
80103ed2:	5d                   	pop    %ebp
80103ed3:	c3                   	ret    
      release(&ptable.lock);
80103ed4:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103edb:	e8 10 06 00 00       	call   801044f0 <release>
}
80103ee0:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80103ee3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103ee8:	5b                   	pop    %ebx
80103ee9:	5e                   	pop    %esi
80103eea:	5f                   	pop    %edi
80103eeb:	5d                   	pop    %ebp
80103eec:	c3                   	ret    
80103eed:	8d 76 00             	lea    0x0(%esi),%esi

80103ef0 <waitpid>:
{ 
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
80103ef4:	56                   	push   %esi
80103ef5:	53                   	push   %ebx
80103ef6:	83 ec 1c             	sub    $0x1c,%esp
80103ef9:	8b 55 08             	mov    0x8(%ebp),%edx
80103efc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct proc *curproc = myproc();
80103eff:	e8 ec f7 ff ff       	call   801036f0 <myproc>
  acquire(&ptable.lock);
80103f04:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  struct proc *curproc = myproc();
80103f0b:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
80103f0d:	e8 6e 05 00 00       	call   80104480 <acquire>
80103f12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103f15:	8d 76 00             	lea    0x0(%esi),%esi
   havekids = 0;
80103f18:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f1a:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f1f:	eb 15                	jmp    80103f36 <waitpid+0x46>
80103f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f28:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103f2e:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103f34:	74 7a                	je     80103fb0 <waitpid+0xc0>
      if(p->parent != curproc)
80103f36:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f39:	75 ed                	jne    80103f28 <waitpid+0x38>
      if(pid == p->pid && p->state == ZOMBIE){ //The system call must wait for a process (not necessary a child process) with a pid that equals to one provided by the pid argument.
80103f3b:	8b 7b 10             	mov    0x10(%ebx),%edi
      havekids = 1;
80103f3e:	b8 01 00 00 00       	mov    $0x1,%eax
      if(pid == p->pid && p->state == ZOMBIE){ //The system call must wait for a process (not necessary a child process) with a pid that equals to one provided by the pid argument.
80103f43:	39 d7                	cmp    %edx,%edi
80103f45:	75 e1                	jne    80103f28 <waitpid+0x38>
80103f47:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f4b:	75 db                	jne    80103f28 <waitpid+0x38>
        kfree(p->kstack);
80103f4d:	8b 43 08             	mov    0x8(%ebx),%eax
80103f50:	89 04 24             	mov    %eax,(%esp)
80103f53:	e8 98 e3 ff ff       	call   801022f0 <kfree>
        freevm(p->pgdir);
80103f58:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80103f5b:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f62:	89 04 24             	mov    %eax,(%esp)
80103f65:	e8 36 2d 00 00       	call   80106ca0 <freevm>
        if(status != 0) { 
80103f6a:	8b 55 0c             	mov    0xc(%ebp),%edx
        p->pid = 0; 
80103f6d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f74:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f7b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        if(status != 0) { 
80103f7f:	85 d2                	test   %edx,%edx
        p->killed = 0;
80103f81:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f88:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status != 0) { 
80103f8f:	74 08                	je     80103f99 <waitpid+0xa9>
                *status = p->exitStatus;
80103f91:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103f94:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103f97:	89 01                	mov    %eax,(%ecx)
        release(&ptable.lock);
80103f99:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fa0:	e8 4b 05 00 00       	call   801044f0 <release>
} //waitpid END
80103fa5:	83 c4 1c             	add    $0x1c,%esp
80103fa8:	89 f8                	mov    %edi,%eax
80103faa:	5b                   	pop    %ebx
80103fab:	5e                   	pop    %esi
80103fac:	5f                   	pop    %edi
80103fad:	5d                   	pop    %ebp
80103fae:	c3                   	ret    
80103faf:	90                   	nop
    if(!havekids || curproc->killed){
80103fb0:	85 c0                	test   %eax,%eax
80103fb2:	74 22                	je     80103fd6 <waitpid+0xe6>
80103fb4:	8b 46 24             	mov    0x24(%esi),%eax
80103fb7:	85 c0                	test   %eax,%eax
80103fb9:	75 1b                	jne    80103fd6 <waitpid+0xe6>
    sleep(curproc, &ptable.lock); // Doc: wait-sleep
80103fbb:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103fc2:	80 
80103fc3:	89 34 24             	mov    %esi,(%esp)
80103fc6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103fc9:	e8 82 fd ff ff       	call   80103d50 <sleep>
   }
80103fce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103fd1:	e9 42 ff ff ff       	jmp    80103f18 <waitpid+0x28>
      release(&ptable.lock);
80103fd6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
      return -1;
80103fdd:	bf ff ff ff ff       	mov    $0xffffffff,%edi
      release(&ptable.lock);
80103fe2:	e8 09 05 00 00       	call   801044f0 <release>
} //waitpid END
80103fe7:	83 c4 1c             	add    $0x1c,%esp
80103fea:	89 f8                	mov    %edi,%eax
80103fec:	5b                   	pop    %ebx
80103fed:	5e                   	pop    %esi
80103fee:	5f                   	pop    %edi
80103fef:	5d                   	pop    %ebp
80103ff0:	c3                   	ret    
80103ff1:	eb 0d                	jmp    80104000 <wakeup>
80103ff3:	90                   	nop
80103ff4:	90                   	nop
80103ff5:	90                   	nop
80103ff6:	90                   	nop
80103ff7:	90                   	nop
80103ff8:	90                   	nop
80103ff9:	90                   	nop
80103ffa:	90                   	nop
80103ffb:	90                   	nop
80103ffc:	90                   	nop
80103ffd:	90                   	nop
80103ffe:	90                   	nop
80103fff:	90                   	nop

80104000 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	53                   	push   %ebx
80104004:	83 ec 14             	sub    $0x14,%esp
80104007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010400a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104011:	e8 6a 04 00 00       	call   80104480 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104016:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010401b:	eb 0f                	jmp    8010402c <wakeup+0x2c>
8010401d:	8d 76 00             	lea    0x0(%esi),%esi
80104020:	05 8c 00 00 00       	add    $0x8c,%eax
80104025:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010402a:	74 24                	je     80104050 <wakeup+0x50>
    if(p->state == SLEEPING && p->chan == chan)
8010402c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104030:	75 ee                	jne    80104020 <wakeup+0x20>
80104032:	3b 58 20             	cmp    0x20(%eax),%ebx
80104035:	75 e9                	jne    80104020 <wakeup+0x20>
      p->state = RUNNABLE;
80104037:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010403e:	05 8c 00 00 00       	add    $0x8c,%eax
80104043:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104048:	75 e2                	jne    8010402c <wakeup+0x2c>
8010404a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  wakeup1(chan);
  release(&ptable.lock);
80104050:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104057:	83 c4 14             	add    $0x14,%esp
8010405a:	5b                   	pop    %ebx
8010405b:	5d                   	pop    %ebp
  release(&ptable.lock);
8010405c:	e9 8f 04 00 00       	jmp    801044f0 <release>
80104061:	eb 0d                	jmp    80104070 <kill>
80104063:	90                   	nop
80104064:	90                   	nop
80104065:	90                   	nop
80104066:	90                   	nop
80104067:	90                   	nop
80104068:	90                   	nop
80104069:	90                   	nop
8010406a:	90                   	nop
8010406b:	90                   	nop
8010406c:	90                   	nop
8010406d:	90                   	nop
8010406e:	90                   	nop
8010406f:	90                   	nop

80104070 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	53                   	push   %ebx
80104074:	83 ec 14             	sub    $0x14,%esp
80104077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010407a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104081:	e8 fa 03 00 00       	call   80104480 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104086:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010408b:	eb 0f                	jmp    8010409c <kill+0x2c>
8010408d:	8d 76 00             	lea    0x0(%esi),%esi
80104090:	05 8c 00 00 00       	add    $0x8c,%eax
80104095:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010409a:	74 3c                	je     801040d8 <kill+0x68>
    if(p->pid == pid){
8010409c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010409f:	75 ef                	jne    80104090 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040a1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801040a5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801040ac:	74 1a                	je     801040c8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801040ae:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040b5:	e8 36 04 00 00       	call   801044f0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801040ba:	83 c4 14             	add    $0x14,%esp
      return 0;
801040bd:	31 c0                	xor    %eax,%eax
}
801040bf:	5b                   	pop    %ebx
801040c0:	5d                   	pop    %ebp
801040c1:	c3                   	ret    
801040c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
801040c8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040cf:	eb dd                	jmp    801040ae <kill+0x3e>
801040d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801040d8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040df:	e8 0c 04 00 00       	call   801044f0 <release>
}
801040e4:	83 c4 14             	add    $0x14,%esp
  return -1;
801040e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040ec:	5b                   	pop    %ebx
801040ed:	5d                   	pop    %ebp
801040ee:	c3                   	ret    
801040ef:	90                   	nop

801040f0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	57                   	push   %edi
801040f4:	56                   	push   %esi
801040f5:	53                   	push   %ebx
801040f6:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801040fb:	83 ec 4c             	sub    $0x4c,%esp
801040fe:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104101:	eb 23                	jmp    80104126 <procdump+0x36>
80104103:	90                   	nop
80104104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104108:	c7 04 24 ba 75 10 80 	movl   $0x801075ba,(%esp)
8010410f:	e8 3c c5 ff ff       	call   80100650 <cprintf>
80104114:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010411a:	81 fb c0 50 11 80    	cmp    $0x801150c0,%ebx
80104120:	0f 84 8a 00 00 00    	je     801041b0 <procdump+0xc0>
    if(p->state == UNUSED)
80104126:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104129:	85 c0                	test   %eax,%eax
8010412b:	74 e7                	je     80104114 <procdump+0x24>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010412d:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104130:	ba f5 75 10 80       	mov    $0x801075f5,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104135:	77 11                	ja     80104148 <procdump+0x58>
80104137:	8b 14 85 7c 76 10 80 	mov    -0x7fef8984(,%eax,4),%edx
      state = "???";
8010413e:	b8 f5 75 10 80       	mov    $0x801075f5,%eax
80104143:	85 d2                	test   %edx,%edx
80104145:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104148:	8b 43 a4             	mov    -0x5c(%ebx),%eax
8010414b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010414f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104153:	c7 04 24 f9 75 10 80 	movl   $0x801075f9,(%esp)
8010415a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010415e:	e8 ed c4 ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80104163:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104167:	75 9f                	jne    80104108 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104169:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010416c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104170:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104173:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104176:	8b 40 0c             	mov    0xc(%eax),%eax
80104179:	83 c0 08             	add    $0x8,%eax
8010417c:	89 04 24             	mov    %eax,(%esp)
8010417f:	e8 ac 01 00 00       	call   80104330 <getcallerpcs>
80104184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104188:	8b 17                	mov    (%edi),%edx
8010418a:	85 d2                	test   %edx,%edx
8010418c:	0f 84 76 ff ff ff    	je     80104108 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104192:	89 54 24 04          	mov    %edx,0x4(%esp)
80104196:	83 c7 04             	add    $0x4,%edi
80104199:	c7 04 24 01 70 10 80 	movl   $0x80107001,(%esp)
801041a0:	e8 ab c4 ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801041a5:	39 f7                	cmp    %esi,%edi
801041a7:	75 df                	jne    80104188 <procdump+0x98>
801041a9:	e9 5a ff ff ff       	jmp    80104108 <procdump+0x18>
801041ae:	66 90                	xchg   %ax,%ax
  }
}
801041b0:	83 c4 4c             	add    $0x4c,%esp
801041b3:	5b                   	pop    %ebx
801041b4:	5e                   	pop    %esi
801041b5:	5f                   	pop    %edi
801041b6:	5d                   	pop    %ebp
801041b7:	c3                   	ret    
801041b8:	90                   	nop
801041b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041c0 <hello>:

void
hello(void) {
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	83 ec 18             	sub    $0x18,%esp
	cprintf("\n\n Hello from your kernal space!! \n\n");
801041c6:	c7 04 24 54 76 10 80 	movl   $0x80107654,(%esp)
801041cd:	e8 7e c4 ff ff       	call   80100650 <cprintf>
} //new for lab1
801041d2:	c9                   	leave  
801041d3:	c3                   	ret    
801041d4:	66 90                	xchg   %ax,%ax
801041d6:	66 90                	xchg   %ax,%ax
801041d8:	66 90                	xchg   %ax,%ax
801041da:	66 90                	xchg   %ax,%ax
801041dc:	66 90                	xchg   %ax,%ax
801041de:	66 90                	xchg   %ax,%ax

801041e0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 14             	sub    $0x14,%esp
801041e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041ea:	c7 44 24 04 94 76 10 	movl   $0x80107694,0x4(%esp)
801041f1:	80 
801041f2:	8d 43 04             	lea    0x4(%ebx),%eax
801041f5:	89 04 24             	mov    %eax,(%esp)
801041f8:	e8 13 01 00 00       	call   80104310 <initlock>
  lk->name = name;
801041fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104200:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104206:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010420d:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104210:	83 c4 14             	add    $0x14,%esp
80104213:	5b                   	pop    %ebx
80104214:	5d                   	pop    %ebp
80104215:	c3                   	ret    
80104216:	8d 76 00             	lea    0x0(%esi),%esi
80104219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104220 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	56                   	push   %esi
80104224:	53                   	push   %ebx
80104225:	83 ec 10             	sub    $0x10,%esp
80104228:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010422b:	8d 73 04             	lea    0x4(%ebx),%esi
8010422e:	89 34 24             	mov    %esi,(%esp)
80104231:	e8 4a 02 00 00       	call   80104480 <acquire>
  while (lk->locked) {
80104236:	8b 13                	mov    (%ebx),%edx
80104238:	85 d2                	test   %edx,%edx
8010423a:	74 16                	je     80104252 <acquiresleep+0x32>
8010423c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104240:	89 74 24 04          	mov    %esi,0x4(%esp)
80104244:	89 1c 24             	mov    %ebx,(%esp)
80104247:	e8 04 fb ff ff       	call   80103d50 <sleep>
  while (lk->locked) {
8010424c:	8b 03                	mov    (%ebx),%eax
8010424e:	85 c0                	test   %eax,%eax
80104250:	75 ee                	jne    80104240 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104252:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104258:	e8 93 f4 ff ff       	call   801036f0 <myproc>
8010425d:	8b 40 10             	mov    0x10(%eax),%eax
80104260:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104263:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104266:	83 c4 10             	add    $0x10,%esp
80104269:	5b                   	pop    %ebx
8010426a:	5e                   	pop    %esi
8010426b:	5d                   	pop    %ebp
  release(&lk->lk);
8010426c:	e9 7f 02 00 00       	jmp    801044f0 <release>
80104271:	eb 0d                	jmp    80104280 <releasesleep>
80104273:	90                   	nop
80104274:	90                   	nop
80104275:	90                   	nop
80104276:	90                   	nop
80104277:	90                   	nop
80104278:	90                   	nop
80104279:	90                   	nop
8010427a:	90                   	nop
8010427b:	90                   	nop
8010427c:	90                   	nop
8010427d:	90                   	nop
8010427e:	90                   	nop
8010427f:	90                   	nop

80104280 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	56                   	push   %esi
80104284:	53                   	push   %ebx
80104285:	83 ec 10             	sub    $0x10,%esp
80104288:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010428b:	8d 73 04             	lea    0x4(%ebx),%esi
8010428e:	89 34 24             	mov    %esi,(%esp)
80104291:	e8 ea 01 00 00       	call   80104480 <acquire>
  lk->locked = 0;
80104296:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010429c:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801042a3:	89 1c 24             	mov    %ebx,(%esp)
801042a6:	e8 55 fd ff ff       	call   80104000 <wakeup>
  release(&lk->lk);
801042ab:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042ae:	83 c4 10             	add    $0x10,%esp
801042b1:	5b                   	pop    %ebx
801042b2:	5e                   	pop    %esi
801042b3:	5d                   	pop    %ebp
  release(&lk->lk);
801042b4:	e9 37 02 00 00       	jmp    801044f0 <release>
801042b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042c0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	57                   	push   %edi
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
801042c4:	31 ff                	xor    %edi,%edi
{
801042c6:	56                   	push   %esi
801042c7:	53                   	push   %ebx
801042c8:	83 ec 1c             	sub    $0x1c,%esp
801042cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042ce:	8d 73 04             	lea    0x4(%ebx),%esi
801042d1:	89 34 24             	mov    %esi,(%esp)
801042d4:	e8 a7 01 00 00       	call   80104480 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801042d9:	8b 03                	mov    (%ebx),%eax
801042db:	85 c0                	test   %eax,%eax
801042dd:	74 13                	je     801042f2 <holdingsleep+0x32>
801042df:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801042e2:	e8 09 f4 ff ff       	call   801036f0 <myproc>
801042e7:	3b 58 10             	cmp    0x10(%eax),%ebx
801042ea:	0f 94 c0             	sete   %al
801042ed:	0f b6 c0             	movzbl %al,%eax
801042f0:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801042f2:	89 34 24             	mov    %esi,(%esp)
801042f5:	e8 f6 01 00 00       	call   801044f0 <release>
  return r;
}
801042fa:	83 c4 1c             	add    $0x1c,%esp
801042fd:	89 f8                	mov    %edi,%eax
801042ff:	5b                   	pop    %ebx
80104300:	5e                   	pop    %esi
80104301:	5f                   	pop    %edi
80104302:	5d                   	pop    %ebp
80104303:	c3                   	ret    
80104304:	66 90                	xchg   %ax,%ax
80104306:	66 90                	xchg   %ax,%ax
80104308:	66 90                	xchg   %ax,%ax
8010430a:	66 90                	xchg   %ax,%ax
8010430c:	66 90                	xchg   %ax,%ax
8010430e:	66 90                	xchg   %ax,%ax

80104310 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104316:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104319:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010431f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104322:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104329:	5d                   	pop    %ebp
8010432a:	c3                   	ret    
8010432b:	90                   	nop
8010432c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104330 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104333:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104336:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104339:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010433a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010433d:	31 c0                	xor    %eax,%eax
8010433f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104340:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104346:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010434c:	77 1a                	ja     80104368 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010434e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104351:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104354:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104357:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104359:	83 f8 0a             	cmp    $0xa,%eax
8010435c:	75 e2                	jne    80104340 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010435e:	5b                   	pop    %ebx
8010435f:	5d                   	pop    %ebp
80104360:	c3                   	ret    
80104361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104368:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010436f:	83 c0 01             	add    $0x1,%eax
80104372:	83 f8 0a             	cmp    $0xa,%eax
80104375:	74 e7                	je     8010435e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104377:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010437e:	83 c0 01             	add    $0x1,%eax
80104381:	83 f8 0a             	cmp    $0xa,%eax
80104384:	75 e2                	jne    80104368 <getcallerpcs+0x38>
80104386:	eb d6                	jmp    8010435e <getcallerpcs+0x2e>
80104388:	90                   	nop
80104389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104390 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	53                   	push   %ebx
80104394:	83 ec 04             	sub    $0x4,%esp
80104397:	9c                   	pushf  
80104398:	5b                   	pop    %ebx
  asm volatile("cli");
80104399:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010439a:	e8 b1 f2 ff ff       	call   80103650 <mycpu>
8010439f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801043a5:	85 c0                	test   %eax,%eax
801043a7:	75 11                	jne    801043ba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801043a9:	e8 a2 f2 ff ff       	call   80103650 <mycpu>
801043ae:	81 e3 00 02 00 00    	and    $0x200,%ebx
801043b4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801043ba:	e8 91 f2 ff ff       	call   80103650 <mycpu>
801043bf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801043c6:	83 c4 04             	add    $0x4,%esp
801043c9:	5b                   	pop    %ebx
801043ca:	5d                   	pop    %ebp
801043cb:	c3                   	ret    
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <popcli>:

void
popcli(void)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043d6:	9c                   	pushf  
801043d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801043d8:	f6 c4 02             	test   $0x2,%ah
801043db:	75 49                	jne    80104426 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801043dd:	e8 6e f2 ff ff       	call   80103650 <mycpu>
801043e2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801043e8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801043eb:	85 d2                	test   %edx,%edx
801043ed:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801043f3:	78 25                	js     8010441a <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801043f5:	e8 56 f2 ff ff       	call   80103650 <mycpu>
801043fa:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104400:	85 d2                	test   %edx,%edx
80104402:	74 04                	je     80104408 <popcli+0x38>
    sti();
}
80104404:	c9                   	leave  
80104405:	c3                   	ret    
80104406:	66 90                	xchg   %ax,%ax
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104408:	e8 43 f2 ff ff       	call   80103650 <mycpu>
8010440d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104413:	85 c0                	test   %eax,%eax
80104415:	74 ed                	je     80104404 <popcli+0x34>
  asm volatile("sti");
80104417:	fb                   	sti    
}
80104418:	c9                   	leave  
80104419:	c3                   	ret    
    panic("popcli");
8010441a:	c7 04 24 b6 76 10 80 	movl   $0x801076b6,(%esp)
80104421:	e8 3a bf ff ff       	call   80100360 <panic>
    panic("popcli - interruptible");
80104426:	c7 04 24 9f 76 10 80 	movl   $0x8010769f,(%esp)
8010442d:	e8 2e bf ff ff       	call   80100360 <panic>
80104432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104440 <holding>:
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
  r = lock->locked && lock->cpu == mycpu();
80104444:	31 f6                	xor    %esi,%esi
{
80104446:	53                   	push   %ebx
80104447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010444a:	e8 41 ff ff ff       	call   80104390 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010444f:	8b 03                	mov    (%ebx),%eax
80104451:	85 c0                	test   %eax,%eax
80104453:	74 12                	je     80104467 <holding+0x27>
80104455:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104458:	e8 f3 f1 ff ff       	call   80103650 <mycpu>
8010445d:	39 c3                	cmp    %eax,%ebx
8010445f:	0f 94 c0             	sete   %al
80104462:	0f b6 c0             	movzbl %al,%eax
80104465:	89 c6                	mov    %eax,%esi
  popcli();
80104467:	e8 64 ff ff ff       	call   801043d0 <popcli>
}
8010446c:	89 f0                	mov    %esi,%eax
8010446e:	5b                   	pop    %ebx
8010446f:	5e                   	pop    %esi
80104470:	5d                   	pop    %ebp
80104471:	c3                   	ret    
80104472:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104480 <acquire>:
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	53                   	push   %ebx
80104484:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104487:	e8 04 ff ff ff       	call   80104390 <pushcli>
  if(holding(lk))
8010448c:	8b 45 08             	mov    0x8(%ebp),%eax
8010448f:	89 04 24             	mov    %eax,(%esp)
80104492:	e8 a9 ff ff ff       	call   80104440 <holding>
80104497:	85 c0                	test   %eax,%eax
80104499:	75 3a                	jne    801044d5 <acquire+0x55>
  asm volatile("lock; xchgl %0, %1" :
8010449b:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
801044a0:	8b 55 08             	mov    0x8(%ebp),%edx
801044a3:	89 c8                	mov    %ecx,%eax
801044a5:	f0 87 02             	lock xchg %eax,(%edx)
801044a8:	85 c0                	test   %eax,%eax
801044aa:	75 f4                	jne    801044a0 <acquire+0x20>
  __sync_synchronize();
801044ac:	0f ae f0             	mfence 
  lk->cpu = mycpu();
801044af:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044b2:	e8 99 f1 ff ff       	call   80103650 <mycpu>
801044b7:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
801044ba:	8b 45 08             	mov    0x8(%ebp),%eax
801044bd:	83 c0 0c             	add    $0xc,%eax
801044c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801044c4:	8d 45 08             	lea    0x8(%ebp),%eax
801044c7:	89 04 24             	mov    %eax,(%esp)
801044ca:	e8 61 fe ff ff       	call   80104330 <getcallerpcs>
}
801044cf:	83 c4 14             	add    $0x14,%esp
801044d2:	5b                   	pop    %ebx
801044d3:	5d                   	pop    %ebp
801044d4:	c3                   	ret    
    panic("acquire");
801044d5:	c7 04 24 bd 76 10 80 	movl   $0x801076bd,(%esp)
801044dc:	e8 7f be ff ff       	call   80100360 <panic>
801044e1:	eb 0d                	jmp    801044f0 <release>
801044e3:	90                   	nop
801044e4:	90                   	nop
801044e5:	90                   	nop
801044e6:	90                   	nop
801044e7:	90                   	nop
801044e8:	90                   	nop
801044e9:	90                   	nop
801044ea:	90                   	nop
801044eb:	90                   	nop
801044ec:	90                   	nop
801044ed:	90                   	nop
801044ee:	90                   	nop
801044ef:	90                   	nop

801044f0 <release>:
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
801044f4:	83 ec 14             	sub    $0x14,%esp
801044f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801044fa:	89 1c 24             	mov    %ebx,(%esp)
801044fd:	e8 3e ff ff ff       	call   80104440 <holding>
80104502:	85 c0                	test   %eax,%eax
80104504:	74 21                	je     80104527 <release+0x37>
  lk->pcs[0] = 0;
80104506:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010450d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104514:	0f ae f0             	mfence 
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104517:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010451d:	83 c4 14             	add    $0x14,%esp
80104520:	5b                   	pop    %ebx
80104521:	5d                   	pop    %ebp
  popcli();
80104522:	e9 a9 fe ff ff       	jmp    801043d0 <popcli>
    panic("release");
80104527:	c7 04 24 c5 76 10 80 	movl   $0x801076c5,(%esp)
8010452e:	e8 2d be ff ff       	call   80100360 <panic>
80104533:	66 90                	xchg   %ax,%ax
80104535:	66 90                	xchg   %ax,%ax
80104537:	66 90                	xchg   %ax,%ax
80104539:	66 90                	xchg   %ax,%ax
8010453b:	66 90                	xchg   %ax,%ax
8010453d:	66 90                	xchg   %ax,%ax
8010453f:	90                   	nop

80104540 <memset>:
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	8b 55 08             	mov    0x8(%ebp),%edx
80104546:	57                   	push   %edi
80104547:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010454a:	53                   	push   %ebx
8010454b:	f6 c2 03             	test   $0x3,%dl
8010454e:	75 05                	jne    80104555 <memset+0x15>
80104550:	f6 c1 03             	test   $0x3,%cl
80104553:	74 13                	je     80104568 <memset+0x28>
80104555:	89 d7                	mov    %edx,%edi
80104557:	8b 45 0c             	mov    0xc(%ebp),%eax
8010455a:	fc                   	cld    
8010455b:	f3 aa                	rep stos %al,%es:(%edi)
8010455d:	5b                   	pop    %ebx
8010455e:	89 d0                	mov    %edx,%eax
80104560:	5f                   	pop    %edi
80104561:	5d                   	pop    %ebp
80104562:	c3                   	ret    
80104563:	90                   	nop
80104564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104568:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
8010456c:	c1 e9 02             	shr    $0x2,%ecx
8010456f:	89 f8                	mov    %edi,%eax
80104571:	89 fb                	mov    %edi,%ebx
80104573:	c1 e0 18             	shl    $0x18,%eax
80104576:	c1 e3 10             	shl    $0x10,%ebx
80104579:	09 d8                	or     %ebx,%eax
8010457b:	09 f8                	or     %edi,%eax
8010457d:	c1 e7 08             	shl    $0x8,%edi
80104580:	09 f8                	or     %edi,%eax
80104582:	89 d7                	mov    %edx,%edi
80104584:	fc                   	cld    
80104585:	f3 ab                	rep stos %eax,%es:(%edi)
80104587:	5b                   	pop    %ebx
80104588:	89 d0                	mov    %edx,%eax
8010458a:	5f                   	pop    %edi
8010458b:	5d                   	pop    %ebp
8010458c:	c3                   	ret    
8010458d:	8d 76 00             	lea    0x0(%esi),%esi

80104590 <memcmp>:
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	8b 45 10             	mov    0x10(%ebp),%eax
80104596:	57                   	push   %edi
80104597:	56                   	push   %esi
80104598:	8b 75 0c             	mov    0xc(%ebp),%esi
8010459b:	53                   	push   %ebx
8010459c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010459f:	85 c0                	test   %eax,%eax
801045a1:	8d 78 ff             	lea    -0x1(%eax),%edi
801045a4:	74 26                	je     801045cc <memcmp+0x3c>
801045a6:	0f b6 03             	movzbl (%ebx),%eax
801045a9:	31 d2                	xor    %edx,%edx
801045ab:	0f b6 0e             	movzbl (%esi),%ecx
801045ae:	38 c8                	cmp    %cl,%al
801045b0:	74 16                	je     801045c8 <memcmp+0x38>
801045b2:	eb 24                	jmp    801045d8 <memcmp+0x48>
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045b8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
801045bd:	83 c2 01             	add    $0x1,%edx
801045c0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801045c4:	38 c8                	cmp    %cl,%al
801045c6:	75 10                	jne    801045d8 <memcmp+0x48>
801045c8:	39 fa                	cmp    %edi,%edx
801045ca:	75 ec                	jne    801045b8 <memcmp+0x28>
801045cc:	5b                   	pop    %ebx
801045cd:	31 c0                	xor    %eax,%eax
801045cf:	5e                   	pop    %esi
801045d0:	5f                   	pop    %edi
801045d1:	5d                   	pop    %ebp
801045d2:	c3                   	ret    
801045d3:	90                   	nop
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045d8:	5b                   	pop    %ebx
801045d9:	29 c8                	sub    %ecx,%eax
801045db:	5e                   	pop    %esi
801045dc:	5f                   	pop    %edi
801045dd:	5d                   	pop    %ebp
801045de:	c3                   	ret    
801045df:	90                   	nop

801045e0 <memmove>:
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	8b 45 08             	mov    0x8(%ebp),%eax
801045e7:	56                   	push   %esi
801045e8:	8b 75 0c             	mov    0xc(%ebp),%esi
801045eb:	53                   	push   %ebx
801045ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
801045ef:	39 c6                	cmp    %eax,%esi
801045f1:	73 35                	jae    80104628 <memmove+0x48>
801045f3:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801045f6:	39 c8                	cmp    %ecx,%eax
801045f8:	73 2e                	jae    80104628 <memmove+0x48>
801045fa:	85 db                	test   %ebx,%ebx
801045fc:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
801045ff:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104602:	74 1b                	je     8010461f <memmove+0x3f>
80104604:	f7 db                	neg    %ebx
80104606:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80104609:	01 fb                	add    %edi,%ebx
8010460b:	90                   	nop
8010460c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104610:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104614:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
80104617:	83 ea 01             	sub    $0x1,%edx
8010461a:	83 fa ff             	cmp    $0xffffffff,%edx
8010461d:	75 f1                	jne    80104610 <memmove+0x30>
8010461f:	5b                   	pop    %ebx
80104620:	5e                   	pop    %esi
80104621:	5f                   	pop    %edi
80104622:	5d                   	pop    %ebp
80104623:	c3                   	ret    
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104628:	31 d2                	xor    %edx,%edx
8010462a:	85 db                	test   %ebx,%ebx
8010462c:	74 f1                	je     8010461f <memmove+0x3f>
8010462e:	66 90                	xchg   %ax,%ax
80104630:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104634:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104637:	83 c2 01             	add    $0x1,%edx
8010463a:	39 da                	cmp    %ebx,%edx
8010463c:	75 f2                	jne    80104630 <memmove+0x50>
8010463e:	5b                   	pop    %ebx
8010463f:	5e                   	pop    %esi
80104640:	5f                   	pop    %edi
80104641:	5d                   	pop    %ebp
80104642:	c3                   	ret    
80104643:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <memcpy>:
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	5d                   	pop    %ebp
80104654:	eb 8a                	jmp    801045e0 <memmove>
80104656:	8d 76 00             	lea    0x0(%esi),%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <strncmp>:
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	8b 75 10             	mov    0x10(%ebp),%esi
80104667:	53                   	push   %ebx
80104668:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010466b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010466e:	85 f6                	test   %esi,%esi
80104670:	74 30                	je     801046a2 <strncmp+0x42>
80104672:	0f b6 01             	movzbl (%ecx),%eax
80104675:	84 c0                	test   %al,%al
80104677:	74 2f                	je     801046a8 <strncmp+0x48>
80104679:	0f b6 13             	movzbl (%ebx),%edx
8010467c:	38 d0                	cmp    %dl,%al
8010467e:	75 46                	jne    801046c6 <strncmp+0x66>
80104680:	8d 51 01             	lea    0x1(%ecx),%edx
80104683:	01 ce                	add    %ecx,%esi
80104685:	eb 14                	jmp    8010469b <strncmp+0x3b>
80104687:	90                   	nop
80104688:	0f b6 02             	movzbl (%edx),%eax
8010468b:	84 c0                	test   %al,%al
8010468d:	74 31                	je     801046c0 <strncmp+0x60>
8010468f:	0f b6 19             	movzbl (%ecx),%ebx
80104692:	83 c2 01             	add    $0x1,%edx
80104695:	38 d8                	cmp    %bl,%al
80104697:	75 17                	jne    801046b0 <strncmp+0x50>
80104699:	89 cb                	mov    %ecx,%ebx
8010469b:	39 f2                	cmp    %esi,%edx
8010469d:	8d 4b 01             	lea    0x1(%ebx),%ecx
801046a0:	75 e6                	jne    80104688 <strncmp+0x28>
801046a2:	5b                   	pop    %ebx
801046a3:	31 c0                	xor    %eax,%eax
801046a5:	5e                   	pop    %esi
801046a6:	5d                   	pop    %ebp
801046a7:	c3                   	ret    
801046a8:	0f b6 1b             	movzbl (%ebx),%ebx
801046ab:	31 c0                	xor    %eax,%eax
801046ad:	8d 76 00             	lea    0x0(%esi),%esi
801046b0:	0f b6 d3             	movzbl %bl,%edx
801046b3:	29 d0                	sub    %edx,%eax
801046b5:	5b                   	pop    %ebx
801046b6:	5e                   	pop    %esi
801046b7:	5d                   	pop    %ebp
801046b8:	c3                   	ret    
801046b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c0:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
801046c4:	eb ea                	jmp    801046b0 <strncmp+0x50>
801046c6:	89 d3                	mov    %edx,%ebx
801046c8:	eb e6                	jmp    801046b0 <strncmp+0x50>
801046ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046d0 <strncpy>:
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	8b 45 08             	mov    0x8(%ebp),%eax
801046d6:	56                   	push   %esi
801046d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046da:	53                   	push   %ebx
801046db:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046de:	89 c2                	mov    %eax,%edx
801046e0:	eb 19                	jmp    801046fb <strncpy+0x2b>
801046e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046e8:	83 c3 01             	add    $0x1,%ebx
801046eb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046ef:	83 c2 01             	add    $0x1,%edx
801046f2:	84 c9                	test   %cl,%cl
801046f4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046f7:	74 09                	je     80104702 <strncpy+0x32>
801046f9:	89 f1                	mov    %esi,%ecx
801046fb:	85 c9                	test   %ecx,%ecx
801046fd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104700:	7f e6                	jg     801046e8 <strncpy+0x18>
80104702:	31 c9                	xor    %ecx,%ecx
80104704:	85 f6                	test   %esi,%esi
80104706:	7e 0f                	jle    80104717 <strncpy+0x47>
80104708:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
8010470c:	89 f3                	mov    %esi,%ebx
8010470e:	83 c1 01             	add    $0x1,%ecx
80104711:	29 cb                	sub    %ecx,%ebx
80104713:	85 db                	test   %ebx,%ebx
80104715:	7f f1                	jg     80104708 <strncpy+0x38>
80104717:	5b                   	pop    %ebx
80104718:	5e                   	pop    %esi
80104719:	5d                   	pop    %ebp
8010471a:	c3                   	ret    
8010471b:	90                   	nop
8010471c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104720 <safestrcpy>:
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104726:	56                   	push   %esi
80104727:	8b 45 08             	mov    0x8(%ebp),%eax
8010472a:	53                   	push   %ebx
8010472b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010472e:	85 c9                	test   %ecx,%ecx
80104730:	7e 26                	jle    80104758 <safestrcpy+0x38>
80104732:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104736:	89 c1                	mov    %eax,%ecx
80104738:	eb 17                	jmp    80104751 <safestrcpy+0x31>
8010473a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104740:	83 c2 01             	add    $0x1,%edx
80104743:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104747:	83 c1 01             	add    $0x1,%ecx
8010474a:	84 db                	test   %bl,%bl
8010474c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010474f:	74 04                	je     80104755 <safestrcpy+0x35>
80104751:	39 f2                	cmp    %esi,%edx
80104753:	75 eb                	jne    80104740 <safestrcpy+0x20>
80104755:	c6 01 00             	movb   $0x0,(%ecx)
80104758:	5b                   	pop    %ebx
80104759:	5e                   	pop    %esi
8010475a:	5d                   	pop    %ebp
8010475b:	c3                   	ret    
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104760 <strlen>:
80104760:	55                   	push   %ebp
80104761:	31 c0                	xor    %eax,%eax
80104763:	89 e5                	mov    %esp,%ebp
80104765:	8b 55 08             	mov    0x8(%ebp),%edx
80104768:	80 3a 00             	cmpb   $0x0,(%edx)
8010476b:	74 0c                	je     80104779 <strlen+0x19>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
80104770:	83 c0 01             	add    $0x1,%eax
80104773:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104777:	75 f7                	jne    80104770 <strlen+0x10>
80104779:	5d                   	pop    %ebp
8010477a:	c3                   	ret    

8010477b <swtch>:
8010477b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010477f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104783:	55                   	push   %ebp
80104784:	53                   	push   %ebx
80104785:	56                   	push   %esi
80104786:	57                   	push   %edi
80104787:	89 20                	mov    %esp,(%eax)
80104789:	89 d4                	mov    %edx,%esp
8010478b:	5f                   	pop    %edi
8010478c:	5e                   	pop    %esi
8010478d:	5b                   	pop    %ebx
8010478e:	5d                   	pop    %ebp
8010478f:	c3                   	ret    

80104790 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	53                   	push   %ebx
80104794:	83 ec 04             	sub    $0x4,%esp
80104797:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010479a:	e8 51 ef ff ff       	call   801036f0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010479f:	8b 00                	mov    (%eax),%eax
801047a1:	39 d8                	cmp    %ebx,%eax
801047a3:	76 1b                	jbe    801047c0 <fetchint+0x30>
801047a5:	8d 53 04             	lea    0x4(%ebx),%edx
801047a8:	39 d0                	cmp    %edx,%eax
801047aa:	72 14                	jb     801047c0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801047ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801047af:	8b 13                	mov    (%ebx),%edx
801047b1:	89 10                	mov    %edx,(%eax)
  return 0;
801047b3:	31 c0                	xor    %eax,%eax
}
801047b5:	83 c4 04             	add    $0x4,%esp
801047b8:	5b                   	pop    %ebx
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801047c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047c5:	eb ee                	jmp    801047b5 <fetchint+0x25>
801047c7:	89 f6                	mov    %esi,%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047d0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	53                   	push   %ebx
801047d4:	83 ec 04             	sub    $0x4,%esp
801047d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801047da:	e8 11 ef ff ff       	call   801036f0 <myproc>

  if(addr >= curproc->sz)
801047df:	39 18                	cmp    %ebx,(%eax)
801047e1:	76 26                	jbe    80104809 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
801047e3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801047e6:	89 da                	mov    %ebx,%edx
801047e8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801047ea:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801047ec:	39 c3                	cmp    %eax,%ebx
801047ee:	73 19                	jae    80104809 <fetchstr+0x39>
    if(*s == 0)
801047f0:	80 3b 00             	cmpb   $0x0,(%ebx)
801047f3:	75 0d                	jne    80104802 <fetchstr+0x32>
801047f5:	eb 21                	jmp    80104818 <fetchstr+0x48>
801047f7:	90                   	nop
801047f8:	80 3a 00             	cmpb   $0x0,(%edx)
801047fb:	90                   	nop
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104800:	74 16                	je     80104818 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80104802:	83 c2 01             	add    $0x1,%edx
80104805:	39 d0                	cmp    %edx,%eax
80104807:	77 ef                	ja     801047f8 <fetchstr+0x28>
      return s - *pp;
  }
  return -1;
}
80104809:	83 c4 04             	add    $0x4,%esp
    return -1;
8010480c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104811:	5b                   	pop    %ebx
80104812:	5d                   	pop    %ebp
80104813:	c3                   	ret    
80104814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104818:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010481b:	89 d0                	mov    %edx,%eax
8010481d:	29 d8                	sub    %ebx,%eax
}
8010481f:	5b                   	pop    %ebx
80104820:	5d                   	pop    %ebp
80104821:	c3                   	ret    
80104822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104830 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	8b 75 0c             	mov    0xc(%ebp),%esi
80104837:	53                   	push   %ebx
80104838:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010483b:	e8 b0 ee ff ff       	call   801036f0 <myproc>
80104840:	89 75 0c             	mov    %esi,0xc(%ebp)
80104843:	8b 40 18             	mov    0x18(%eax),%eax
80104846:	8b 40 44             	mov    0x44(%eax),%eax
80104849:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
8010484d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80104850:	5b                   	pop    %ebx
80104851:	5e                   	pop    %esi
80104852:	5d                   	pop    %ebp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104853:	e9 38 ff ff ff       	jmp    80104790 <fetchint>
80104858:	90                   	nop
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104860 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	56                   	push   %esi
80104864:	53                   	push   %ebx
80104865:	83 ec 20             	sub    $0x20,%esp
80104868:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010486b:	e8 80 ee ff ff       	call   801036f0 <myproc>
80104870:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104872:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104875:	89 44 24 04          	mov    %eax,0x4(%esp)
80104879:	8b 45 08             	mov    0x8(%ebp),%eax
8010487c:	89 04 24             	mov    %eax,(%esp)
8010487f:	e8 ac ff ff ff       	call   80104830 <argint>
80104884:	85 c0                	test   %eax,%eax
80104886:	78 28                	js     801048b0 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104888:	85 db                	test   %ebx,%ebx
8010488a:	78 24                	js     801048b0 <argptr+0x50>
8010488c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010488f:	8b 06                	mov    (%esi),%eax
80104891:	39 c2                	cmp    %eax,%edx
80104893:	73 1b                	jae    801048b0 <argptr+0x50>
80104895:	01 d3                	add    %edx,%ebx
80104897:	39 d8                	cmp    %ebx,%eax
80104899:	72 15                	jb     801048b0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010489b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010489e:	89 10                	mov    %edx,(%eax)
  return 0;
}
801048a0:	83 c4 20             	add    $0x20,%esp
  return 0;
801048a3:	31 c0                	xor    %eax,%eax
}
801048a5:	5b                   	pop    %ebx
801048a6:	5e                   	pop    %esi
801048a7:	5d                   	pop    %ebp
801048a8:	c3                   	ret    
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b0:	83 c4 20             	add    $0x20,%esp
    return -1;
801048b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801048b8:	5b                   	pop    %ebx
801048b9:	5e                   	pop    %esi
801048ba:	5d                   	pop    %ebp
801048bb:	c3                   	ret    
801048bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048c0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
801048c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801048cd:	8b 45 08             	mov    0x8(%ebp),%eax
801048d0:	89 04 24             	mov    %eax,(%esp)
801048d3:	e8 58 ff ff ff       	call   80104830 <argint>
801048d8:	85 c0                	test   %eax,%eax
801048da:	78 14                	js     801048f0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801048dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801048df:	89 44 24 04          	mov    %eax,0x4(%esp)
801048e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e6:	89 04 24             	mov    %eax,(%esp)
801048e9:	e8 e2 fe ff ff       	call   801047d0 <fetchstr>
}
801048ee:	c9                   	leave  
801048ef:	c3                   	ret    
    return -1;
801048f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801048f5:	c9                   	leave  
801048f6:	c3                   	ret    
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104900 <syscall>:
[SYS_set_prior] sys_set_prior, //new for lab2
};

void
syscall(void)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	56                   	push   %esi
80104904:	53                   	push   %ebx
80104905:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104908:	e8 e3 ed ff ff       	call   801036f0 <myproc>

  num = curproc->tf->eax;
8010490d:	8b 70 18             	mov    0x18(%eax),%esi
  struct proc *curproc = myproc();
80104910:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104912:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104915:	8d 50 ff             	lea    -0x1(%eax),%edx
80104918:	83 fa 17             	cmp    $0x17,%edx
8010491b:	77 1b                	ja     80104938 <syscall+0x38>
8010491d:	8b 14 85 00 77 10 80 	mov    -0x7fef8900(,%eax,4),%edx
80104924:	85 d2                	test   %edx,%edx
80104926:	74 10                	je     80104938 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104928:	ff d2                	call   *%edx
8010492a:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010492d:	83 c4 10             	add    $0x10,%esp
80104930:	5b                   	pop    %ebx
80104931:	5e                   	pop    %esi
80104932:	5d                   	pop    %ebp
80104933:	c3                   	ret    
80104934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104938:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010493c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010493f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104943:	8b 43 10             	mov    0x10(%ebx),%eax
80104946:	c7 04 24 cd 76 10 80 	movl   $0x801076cd,(%esp)
8010494d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104951:	e8 fa bc ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80104956:	8b 43 18             	mov    0x18(%ebx),%eax
80104959:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104960:	83 c4 10             	add    $0x10,%esp
80104963:	5b                   	pop    %ebx
80104964:	5e                   	pop    %esi
80104965:	5d                   	pop    %ebp
80104966:	c3                   	ret    
80104967:	66 90                	xchg   %ax,%ax
80104969:	66 90                	xchg   %ax,%ax
8010496b:	66 90                	xchg   %ax,%ax
8010496d:	66 90                	xchg   %ax,%ax
8010496f:	90                   	nop

80104970 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	53                   	push   %ebx
80104974:	89 c3                	mov    %eax,%ebx
80104976:	83 ec 04             	sub    $0x4,%esp
  int fd;
  struct proc *curproc = myproc();
80104979:	e8 72 ed ff ff       	call   801036f0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
8010497e:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
80104980:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104984:	85 c9                	test   %ecx,%ecx
80104986:	74 18                	je     801049a0 <fdalloc+0x30>
  for(fd = 0; fd < NOFILE; fd++){
80104988:	83 c2 01             	add    $0x1,%edx
8010498b:	83 fa 10             	cmp    $0x10,%edx
8010498e:	75 f0                	jne    80104980 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
80104990:	83 c4 04             	add    $0x4,%esp
  return -1;
80104993:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104998:	5b                   	pop    %ebx
80104999:	5d                   	pop    %ebp
8010499a:	c3                   	ret    
8010499b:	90                   	nop
8010499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
801049a0:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
}
801049a4:	83 c4 04             	add    $0x4,%esp
      return fd;
801049a7:	89 d0                	mov    %edx,%eax
}
801049a9:	5b                   	pop    %ebx
801049aa:	5d                   	pop    %ebp
801049ab:	c3                   	ret    
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049b0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	56                   	push   %esi
801049b5:	53                   	push   %ebx
801049b6:	83 ec 3c             	sub    $0x3c,%esp
801049b9:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801049bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801049bf:	8d 5d da             	lea    -0x26(%ebp),%ebx
801049c2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801049c6:	89 04 24             	mov    %eax,(%esp)
{
801049c9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801049cc:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801049cf:	e8 4c d5 ff ff       	call   80101f20 <nameiparent>
801049d4:	85 c0                	test   %eax,%eax
801049d6:	89 c7                	mov    %eax,%edi
801049d8:	0f 84 da 00 00 00    	je     80104ab8 <create+0x108>
    return 0;
  ilock(dp);
801049de:	89 04 24             	mov    %eax,(%esp)
801049e1:	e8 ca cc ff ff       	call   801016b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801049e6:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801049ed:	00 
801049ee:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801049f2:	89 3c 24             	mov    %edi,(%esp)
801049f5:	e8 c6 d1 ff ff       	call   80101bc0 <dirlookup>
801049fa:	85 c0                	test   %eax,%eax
801049fc:	89 c6                	mov    %eax,%esi
801049fe:	74 40                	je     80104a40 <create+0x90>
    iunlockput(dp);
80104a00:	89 3c 24             	mov    %edi,(%esp)
80104a03:	e8 08 cf ff ff       	call   80101910 <iunlockput>
    ilock(ip);
80104a08:	89 34 24             	mov    %esi,(%esp)
80104a0b:	e8 a0 cc ff ff       	call   801016b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a10:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104a15:	75 11                	jne    80104a28 <create+0x78>
80104a17:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104a1c:	89 f0                	mov    %esi,%eax
80104a1e:	75 08                	jne    80104a28 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a20:	83 c4 3c             	add    $0x3c,%esp
80104a23:	5b                   	pop    %ebx
80104a24:	5e                   	pop    %esi
80104a25:	5f                   	pop    %edi
80104a26:	5d                   	pop    %ebp
80104a27:	c3                   	ret    
    iunlockput(ip);
80104a28:	89 34 24             	mov    %esi,(%esp)
80104a2b:	e8 e0 ce ff ff       	call   80101910 <iunlockput>
}
80104a30:	83 c4 3c             	add    $0x3c,%esp
    return 0;
80104a33:	31 c0                	xor    %eax,%eax
}
80104a35:	5b                   	pop    %ebx
80104a36:	5e                   	pop    %esi
80104a37:	5f                   	pop    %edi
80104a38:	5d                   	pop    %ebp
80104a39:	c3                   	ret    
80104a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80104a40:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104a44:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a48:	8b 07                	mov    (%edi),%eax
80104a4a:	89 04 24             	mov    %eax,(%esp)
80104a4d:	e8 ce ca ff ff       	call   80101520 <ialloc>
80104a52:	85 c0                	test   %eax,%eax
80104a54:	89 c6                	mov    %eax,%esi
80104a56:	0f 84 bf 00 00 00    	je     80104b1b <create+0x16b>
  ilock(ip);
80104a5c:	89 04 24             	mov    %eax,(%esp)
80104a5f:	e8 4c cc ff ff       	call   801016b0 <ilock>
  ip->major = major;
80104a64:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104a68:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104a6c:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104a70:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104a74:	b8 01 00 00 00       	mov    $0x1,%eax
80104a79:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104a7d:	89 34 24             	mov    %esi,(%esp)
80104a80:	e8 6b cb ff ff       	call   801015f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104a85:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104a8a:	74 34                	je     80104ac0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104a8c:	8b 46 04             	mov    0x4(%esi),%eax
80104a8f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104a93:	89 3c 24             	mov    %edi,(%esp)
80104a96:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a9a:	e8 81 d3 ff ff       	call   80101e20 <dirlink>
80104a9f:	85 c0                	test   %eax,%eax
80104aa1:	78 6c                	js     80104b0f <create+0x15f>
  iunlockput(dp);
80104aa3:	89 3c 24             	mov    %edi,(%esp)
80104aa6:	e8 65 ce ff ff       	call   80101910 <iunlockput>
}
80104aab:	83 c4 3c             	add    $0x3c,%esp
  return ip;
80104aae:	89 f0                	mov    %esi,%eax
}
80104ab0:	5b                   	pop    %ebx
80104ab1:	5e                   	pop    %esi
80104ab2:	5f                   	pop    %edi
80104ab3:	5d                   	pop    %ebp
80104ab4:	c3                   	ret    
80104ab5:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
80104ab8:	31 c0                	xor    %eax,%eax
80104aba:	e9 61 ff ff ff       	jmp    80104a20 <create+0x70>
80104abf:	90                   	nop
    dp->nlink++;  // for ".."
80104ac0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104ac5:	89 3c 24             	mov    %edi,(%esp)
80104ac8:	e8 23 cb ff ff       	call   801015f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104acd:	8b 46 04             	mov    0x4(%esi),%eax
80104ad0:	c7 44 24 04 80 77 10 	movl   $0x80107780,0x4(%esp)
80104ad7:	80 
80104ad8:	89 34 24             	mov    %esi,(%esp)
80104adb:	89 44 24 08          	mov    %eax,0x8(%esp)
80104adf:	e8 3c d3 ff ff       	call   80101e20 <dirlink>
80104ae4:	85 c0                	test   %eax,%eax
80104ae6:	78 1b                	js     80104b03 <create+0x153>
80104ae8:	8b 47 04             	mov    0x4(%edi),%eax
80104aeb:	c7 44 24 04 7f 77 10 	movl   $0x8010777f,0x4(%esp)
80104af2:	80 
80104af3:	89 34 24             	mov    %esi,(%esp)
80104af6:	89 44 24 08          	mov    %eax,0x8(%esp)
80104afa:	e8 21 d3 ff ff       	call   80101e20 <dirlink>
80104aff:	85 c0                	test   %eax,%eax
80104b01:	79 89                	jns    80104a8c <create+0xdc>
      panic("create dots");
80104b03:	c7 04 24 73 77 10 80 	movl   $0x80107773,(%esp)
80104b0a:	e8 51 b8 ff ff       	call   80100360 <panic>
    panic("create: dirlink");
80104b0f:	c7 04 24 82 77 10 80 	movl   $0x80107782,(%esp)
80104b16:	e8 45 b8 ff ff       	call   80100360 <panic>
    panic("create: ialloc");
80104b1b:	c7 04 24 64 77 10 80 	movl   $0x80107764,(%esp)
80104b22:	e8 39 b8 ff ff       	call   80100360 <panic>
80104b27:	89 f6                	mov    %esi,%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	89 c6                	mov    %eax,%esi
80104b36:	53                   	push   %ebx
80104b37:	89 d3                	mov    %edx,%ebx
80104b39:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
80104b3c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b43:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104b4a:	e8 e1 fc ff ff       	call   80104830 <argint>
80104b4f:	85 c0                	test   %eax,%eax
80104b51:	78 2d                	js     80104b80 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104b53:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104b57:	77 27                	ja     80104b80 <argfd.constprop.0+0x50>
80104b59:	e8 92 eb ff ff       	call   801036f0 <myproc>
80104b5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b61:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104b65:	85 c0                	test   %eax,%eax
80104b67:	74 17                	je     80104b80 <argfd.constprop.0+0x50>
  if(pfd)
80104b69:	85 f6                	test   %esi,%esi
80104b6b:	74 02                	je     80104b6f <argfd.constprop.0+0x3f>
    *pfd = fd;
80104b6d:	89 16                	mov    %edx,(%esi)
  if(pf)
80104b6f:	85 db                	test   %ebx,%ebx
80104b71:	74 1d                	je     80104b90 <argfd.constprop.0+0x60>
    *pf = f;
80104b73:	89 03                	mov    %eax,(%ebx)
  return 0;
80104b75:	31 c0                	xor    %eax,%eax
}
80104b77:	83 c4 20             	add    $0x20,%esp
80104b7a:	5b                   	pop    %ebx
80104b7b:	5e                   	pop    %esi
80104b7c:	5d                   	pop    %ebp
80104b7d:	c3                   	ret    
80104b7e:	66 90                	xchg   %ax,%ax
80104b80:	83 c4 20             	add    $0x20,%esp
    return -1;
80104b83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b88:	5b                   	pop    %ebx
80104b89:	5e                   	pop    %esi
80104b8a:	5d                   	pop    %ebp
80104b8b:	c3                   	ret    
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
80104b90:	31 c0                	xor    %eax,%eax
80104b92:	eb e3                	jmp    80104b77 <argfd.constprop.0+0x47>
80104b94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ba0 <sys_dup>:
{
80104ba0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104ba1:	31 c0                	xor    %eax,%eax
{
80104ba3:	89 e5                	mov    %esp,%ebp
80104ba5:	53                   	push   %ebx
80104ba6:	83 ec 24             	sub    $0x24,%esp
  if(argfd(0, 0, &f) < 0)
80104ba9:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104bac:	e8 7f ff ff ff       	call   80104b30 <argfd.constprop.0>
80104bb1:	85 c0                	test   %eax,%eax
80104bb3:	78 23                	js     80104bd8 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
80104bb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bb8:	e8 b3 fd ff ff       	call   80104970 <fdalloc>
80104bbd:	85 c0                	test   %eax,%eax
80104bbf:	89 c3                	mov    %eax,%ebx
80104bc1:	78 15                	js     80104bd8 <sys_dup+0x38>
  filedup(f);
80104bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc6:	89 04 24             	mov    %eax,(%esp)
80104bc9:	e8 12 c2 ff ff       	call   80100de0 <filedup>
  return fd;
80104bce:	89 d8                	mov    %ebx,%eax
}
80104bd0:	83 c4 24             	add    $0x24,%esp
80104bd3:	5b                   	pop    %ebx
80104bd4:	5d                   	pop    %ebp
80104bd5:	c3                   	ret    
80104bd6:	66 90                	xchg   %ax,%ax
    return -1;
80104bd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bdd:	eb f1                	jmp    80104bd0 <sys_dup+0x30>
80104bdf:	90                   	nop

80104be0 <sys_read>:
{
80104be0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104be1:	31 c0                	xor    %eax,%eax
{
80104be3:	89 e5                	mov    %esp,%ebp
80104be5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104be8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104beb:	e8 40 ff ff ff       	call   80104b30 <argfd.constprop.0>
80104bf0:	85 c0                	test   %eax,%eax
80104bf2:	78 54                	js     80104c48 <sys_read+0x68>
80104bf4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104bf7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bfb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104c02:	e8 29 fc ff ff       	call   80104830 <argint>
80104c07:	85 c0                	test   %eax,%eax
80104c09:	78 3d                	js     80104c48 <sys_read+0x68>
80104c0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c0e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c15:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c20:	e8 3b fc ff ff       	call   80104860 <argptr>
80104c25:	85 c0                	test   %eax,%eax
80104c27:	78 1f                	js     80104c48 <sys_read+0x68>
  return fileread(f, p, n);
80104c29:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c2c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c33:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c37:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c3a:	89 04 24             	mov    %eax,(%esp)
80104c3d:	e8 fe c2 ff ff       	call   80100f40 <fileread>
}
80104c42:	c9                   	leave  
80104c43:	c3                   	ret    
80104c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c4d:	c9                   	leave  
80104c4e:	c3                   	ret    
80104c4f:	90                   	nop

80104c50 <sys_write>:
{
80104c50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c51:	31 c0                	xor    %eax,%eax
{
80104c53:	89 e5                	mov    %esp,%ebp
80104c55:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c5b:	e8 d0 fe ff ff       	call   80104b30 <argfd.constprop.0>
80104c60:	85 c0                	test   %eax,%eax
80104c62:	78 54                	js     80104cb8 <sys_write+0x68>
80104c64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c67:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c6b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104c72:	e8 b9 fb ff ff       	call   80104830 <argint>
80104c77:	85 c0                	test   %eax,%eax
80104c79:	78 3d                	js     80104cb8 <sys_write+0x68>
80104c7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c85:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c90:	e8 cb fb ff ff       	call   80104860 <argptr>
80104c95:	85 c0                	test   %eax,%eax
80104c97:	78 1f                	js     80104cb8 <sys_write+0x68>
  return filewrite(f, p, n);
80104c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c9c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ca3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ca7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104caa:	89 04 24             	mov    %eax,(%esp)
80104cad:	e8 2e c3 ff ff       	call   80100fe0 <filewrite>
}
80104cb2:	c9                   	leave  
80104cb3:	c3                   	ret    
80104cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104cb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cbd:	c9                   	leave  
80104cbe:	c3                   	ret    
80104cbf:	90                   	nop

80104cc0 <sys_close>:
{
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80104cc6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104cc9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ccc:	e8 5f fe ff ff       	call   80104b30 <argfd.constprop.0>
80104cd1:	85 c0                	test   %eax,%eax
80104cd3:	78 23                	js     80104cf8 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80104cd5:	e8 16 ea ff ff       	call   801036f0 <myproc>
80104cda:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104cdd:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104ce4:	00 
  fileclose(f);
80104ce5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ce8:	89 04 24             	mov    %eax,(%esp)
80104ceb:	e8 40 c1 ff ff       	call   80100e30 <fileclose>
  return 0;
80104cf0:	31 c0                	xor    %eax,%eax
}
80104cf2:	c9                   	leave  
80104cf3:	c3                   	ret    
80104cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104cf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cfd:	c9                   	leave  
80104cfe:	c3                   	ret    
80104cff:	90                   	nop

80104d00 <sys_fstat>:
{
80104d00:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d01:	31 c0                	xor    %eax,%eax
{
80104d03:	89 e5                	mov    %esp,%ebp
80104d05:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d08:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d0b:	e8 20 fe ff ff       	call   80104b30 <argfd.constprop.0>
80104d10:	85 c0                	test   %eax,%eax
80104d12:	78 34                	js     80104d48 <sys_fstat+0x48>
80104d14:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d17:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104d1e:	00 
80104d1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d23:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104d2a:	e8 31 fb ff ff       	call   80104860 <argptr>
80104d2f:	85 c0                	test   %eax,%eax
80104d31:	78 15                	js     80104d48 <sys_fstat+0x48>
  return filestat(f, st);
80104d33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d36:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d3d:	89 04 24             	mov    %eax,(%esp)
80104d40:	e8 ab c1 ff ff       	call   80100ef0 <filestat>
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	90                   	nop
    return -1;
80104d48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d4d:	c9                   	leave  
80104d4e:	c3                   	ret    
80104d4f:	90                   	nop

80104d50 <sys_link>:
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	57                   	push   %edi
80104d54:	56                   	push   %esi
80104d55:	53                   	push   %ebx
80104d56:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d59:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104d5c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d60:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104d67:	e8 54 fb ff ff       	call   801048c0 <argstr>
80104d6c:	85 c0                	test   %eax,%eax
80104d6e:	0f 88 e6 00 00 00    	js     80104e5a <sys_link+0x10a>
80104d74:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104d77:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104d82:	e8 39 fb ff ff       	call   801048c0 <argstr>
80104d87:	85 c0                	test   %eax,%eax
80104d89:	0f 88 cb 00 00 00    	js     80104e5a <sys_link+0x10a>
  begin_op();
80104d8f:	e8 7c dd ff ff       	call   80102b10 <begin_op>
  if((ip = namei(old)) == 0){
80104d94:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104d97:	89 04 24             	mov    %eax,(%esp)
80104d9a:	e8 61 d1 ff ff       	call   80101f00 <namei>
80104d9f:	85 c0                	test   %eax,%eax
80104da1:	89 c3                	mov    %eax,%ebx
80104da3:	0f 84 ac 00 00 00    	je     80104e55 <sys_link+0x105>
  ilock(ip);
80104da9:	89 04 24             	mov    %eax,(%esp)
80104dac:	e8 ff c8 ff ff       	call   801016b0 <ilock>
  if(ip->type == T_DIR){
80104db1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104db6:	0f 84 91 00 00 00    	je     80104e4d <sys_link+0xfd>
  ip->nlink++;
80104dbc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104dc1:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104dc4:	89 1c 24             	mov    %ebx,(%esp)
80104dc7:	e8 24 c8 ff ff       	call   801015f0 <iupdate>
  iunlock(ip);
80104dcc:	89 1c 24             	mov    %ebx,(%esp)
80104dcf:	e8 bc c9 ff ff       	call   80101790 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104dd4:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104dd7:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104ddb:	89 04 24             	mov    %eax,(%esp)
80104dde:	e8 3d d1 ff ff       	call   80101f20 <nameiparent>
80104de3:	85 c0                	test   %eax,%eax
80104de5:	89 c6                	mov    %eax,%esi
80104de7:	74 4f                	je     80104e38 <sys_link+0xe8>
  ilock(dp);
80104de9:	89 04 24             	mov    %eax,(%esp)
80104dec:	e8 bf c8 ff ff       	call   801016b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104df1:	8b 03                	mov    (%ebx),%eax
80104df3:	39 06                	cmp    %eax,(%esi)
80104df5:	75 39                	jne    80104e30 <sys_link+0xe0>
80104df7:	8b 43 04             	mov    0x4(%ebx),%eax
80104dfa:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104dfe:	89 34 24             	mov    %esi,(%esp)
80104e01:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e05:	e8 16 d0 ff ff       	call   80101e20 <dirlink>
80104e0a:	85 c0                	test   %eax,%eax
80104e0c:	78 22                	js     80104e30 <sys_link+0xe0>
  iunlockput(dp);
80104e0e:	89 34 24             	mov    %esi,(%esp)
80104e11:	e8 fa ca ff ff       	call   80101910 <iunlockput>
  iput(ip);
80104e16:	89 1c 24             	mov    %ebx,(%esp)
80104e19:	e8 b2 c9 ff ff       	call   801017d0 <iput>
  end_op();
80104e1e:	e8 5d dd ff ff       	call   80102b80 <end_op>
}
80104e23:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80104e26:	31 c0                	xor    %eax,%eax
}
80104e28:	5b                   	pop    %ebx
80104e29:	5e                   	pop    %esi
80104e2a:	5f                   	pop    %edi
80104e2b:	5d                   	pop    %ebp
80104e2c:	c3                   	ret    
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80104e30:	89 34 24             	mov    %esi,(%esp)
80104e33:	e8 d8 ca ff ff       	call   80101910 <iunlockput>
  ilock(ip);
80104e38:	89 1c 24             	mov    %ebx,(%esp)
80104e3b:	e8 70 c8 ff ff       	call   801016b0 <ilock>
  ip->nlink--;
80104e40:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e45:	89 1c 24             	mov    %ebx,(%esp)
80104e48:	e8 a3 c7 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
80104e4d:	89 1c 24             	mov    %ebx,(%esp)
80104e50:	e8 bb ca ff ff       	call   80101910 <iunlockput>
  end_op();
80104e55:	e8 26 dd ff ff       	call   80102b80 <end_op>
}
80104e5a:	83 c4 3c             	add    $0x3c,%esp
  return -1;
80104e5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e62:	5b                   	pop    %ebx
80104e63:	5e                   	pop    %esi
80104e64:	5f                   	pop    %edi
80104e65:	5d                   	pop    %ebp
80104e66:	c3                   	ret    
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <sys_unlink>:
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	57                   	push   %edi
80104e74:	56                   	push   %esi
80104e75:	53                   	push   %ebx
80104e76:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80104e79:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104e7c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e87:	e8 34 fa ff ff       	call   801048c0 <argstr>
80104e8c:	85 c0                	test   %eax,%eax
80104e8e:	0f 88 76 01 00 00    	js     8010500a <sys_unlink+0x19a>
  begin_op();
80104e94:	e8 77 dc ff ff       	call   80102b10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104e99:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104e9c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104e9f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104ea3:	89 04 24             	mov    %eax,(%esp)
80104ea6:	e8 75 d0 ff ff       	call   80101f20 <nameiparent>
80104eab:	85 c0                	test   %eax,%eax
80104ead:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104eb0:	0f 84 4f 01 00 00    	je     80105005 <sys_unlink+0x195>
  ilock(dp);
80104eb6:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104eb9:	89 34 24             	mov    %esi,(%esp)
80104ebc:	e8 ef c7 ff ff       	call   801016b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104ec1:	c7 44 24 04 80 77 10 	movl   $0x80107780,0x4(%esp)
80104ec8:	80 
80104ec9:	89 1c 24             	mov    %ebx,(%esp)
80104ecc:	e8 bf cc ff ff       	call   80101b90 <namecmp>
80104ed1:	85 c0                	test   %eax,%eax
80104ed3:	0f 84 21 01 00 00    	je     80104ffa <sys_unlink+0x18a>
80104ed9:	c7 44 24 04 7f 77 10 	movl   $0x8010777f,0x4(%esp)
80104ee0:	80 
80104ee1:	89 1c 24             	mov    %ebx,(%esp)
80104ee4:	e8 a7 cc ff ff       	call   80101b90 <namecmp>
80104ee9:	85 c0                	test   %eax,%eax
80104eeb:	0f 84 09 01 00 00    	je     80104ffa <sys_unlink+0x18a>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104ef1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104ef4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104ef8:	89 44 24 08          	mov    %eax,0x8(%esp)
80104efc:	89 34 24             	mov    %esi,(%esp)
80104eff:	e8 bc cc ff ff       	call   80101bc0 <dirlookup>
80104f04:	85 c0                	test   %eax,%eax
80104f06:	89 c3                	mov    %eax,%ebx
80104f08:	0f 84 ec 00 00 00    	je     80104ffa <sys_unlink+0x18a>
  ilock(ip);
80104f0e:	89 04 24             	mov    %eax,(%esp)
80104f11:	e8 9a c7 ff ff       	call   801016b0 <ilock>
  if(ip->nlink < 1)
80104f16:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104f1b:	0f 8e 24 01 00 00    	jle    80105045 <sys_unlink+0x1d5>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104f21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f26:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104f29:	74 7d                	je     80104fa8 <sys_unlink+0x138>
  memset(&de, 0, sizeof(de));
80104f2b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104f32:	00 
80104f33:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104f3a:	00 
80104f3b:	89 34 24             	mov    %esi,(%esp)
80104f3e:	e8 fd f5 ff ff       	call   80104540 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f43:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104f46:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104f4d:	00 
80104f4e:	89 74 24 04          	mov    %esi,0x4(%esp)
80104f52:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f56:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104f59:	89 04 24             	mov    %eax,(%esp)
80104f5c:	e8 ff ca ff ff       	call   80101a60 <writei>
80104f61:	83 f8 10             	cmp    $0x10,%eax
80104f64:	0f 85 cf 00 00 00    	jne    80105039 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80104f6a:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f6f:	0f 84 a3 00 00 00    	je     80105018 <sys_unlink+0x1a8>
  iunlockput(dp);
80104f75:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104f78:	89 04 24             	mov    %eax,(%esp)
80104f7b:	e8 90 c9 ff ff       	call   80101910 <iunlockput>
  ip->nlink--;
80104f80:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f85:	89 1c 24             	mov    %ebx,(%esp)
80104f88:	e8 63 c6 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
80104f8d:	89 1c 24             	mov    %ebx,(%esp)
80104f90:	e8 7b c9 ff ff       	call   80101910 <iunlockput>
  end_op();
80104f95:	e8 e6 db ff ff       	call   80102b80 <end_op>
}
80104f9a:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80104f9d:	31 c0                	xor    %eax,%eax
}
80104f9f:	5b                   	pop    %ebx
80104fa0:	5e                   	pop    %esi
80104fa1:	5f                   	pop    %edi
80104fa2:	5d                   	pop    %ebp
80104fa3:	c3                   	ret    
80104fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104fa8:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104fac:	0f 86 79 ff ff ff    	jbe    80104f2b <sys_unlink+0xbb>
80104fb2:	bf 20 00 00 00       	mov    $0x20,%edi
80104fb7:	eb 15                	jmp    80104fce <sys_unlink+0x15e>
80104fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fc0:	8d 57 10             	lea    0x10(%edi),%edx
80104fc3:	3b 53 58             	cmp    0x58(%ebx),%edx
80104fc6:	0f 83 5f ff ff ff    	jae    80104f2b <sys_unlink+0xbb>
80104fcc:	89 d7                	mov    %edx,%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104fce:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104fd5:	00 
80104fd6:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104fda:	89 74 24 04          	mov    %esi,0x4(%esp)
80104fde:	89 1c 24             	mov    %ebx,(%esp)
80104fe1:	e8 7a c9 ff ff       	call   80101960 <readi>
80104fe6:	83 f8 10             	cmp    $0x10,%eax
80104fe9:	75 42                	jne    8010502d <sys_unlink+0x1bd>
    if(de.inum != 0)
80104feb:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104ff0:	74 ce                	je     80104fc0 <sys_unlink+0x150>
    iunlockput(ip);
80104ff2:	89 1c 24             	mov    %ebx,(%esp)
80104ff5:	e8 16 c9 ff ff       	call   80101910 <iunlockput>
  iunlockput(dp);
80104ffa:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104ffd:	89 04 24             	mov    %eax,(%esp)
80105000:	e8 0b c9 ff ff       	call   80101910 <iunlockput>
  end_op();
80105005:	e8 76 db ff ff       	call   80102b80 <end_op>
}
8010500a:	83 c4 5c             	add    $0x5c,%esp
  return -1;
8010500d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105012:	5b                   	pop    %ebx
80105013:	5e                   	pop    %esi
80105014:	5f                   	pop    %edi
80105015:	5d                   	pop    %ebp
80105016:	c3                   	ret    
80105017:	90                   	nop
    dp->nlink--;
80105018:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010501b:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105020:	89 04 24             	mov    %eax,(%esp)
80105023:	e8 c8 c5 ff ff       	call   801015f0 <iupdate>
80105028:	e9 48 ff ff ff       	jmp    80104f75 <sys_unlink+0x105>
      panic("isdirempty: readi");
8010502d:	c7 04 24 a4 77 10 80 	movl   $0x801077a4,(%esp)
80105034:	e8 27 b3 ff ff       	call   80100360 <panic>
    panic("unlink: writei");
80105039:	c7 04 24 b6 77 10 80 	movl   $0x801077b6,(%esp)
80105040:	e8 1b b3 ff ff       	call   80100360 <panic>
    panic("unlink: nlink < 1");
80105045:	c7 04 24 92 77 10 80 	movl   $0x80107792,(%esp)
8010504c:	e8 0f b3 ff ff       	call   80100360 <panic>
80105051:	eb 0d                	jmp    80105060 <sys_open>
80105053:	90                   	nop
80105054:	90                   	nop
80105055:	90                   	nop
80105056:	90                   	nop
80105057:	90                   	nop
80105058:	90                   	nop
80105059:	90                   	nop
8010505a:	90                   	nop
8010505b:	90                   	nop
8010505c:	90                   	nop
8010505d:	90                   	nop
8010505e:	90                   	nop
8010505f:	90                   	nop

80105060 <sys_open>:

int
sys_open(void)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	57                   	push   %edi
80105064:	56                   	push   %esi
80105065:	53                   	push   %ebx
80105066:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105069:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010506c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105070:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105077:	e8 44 f8 ff ff       	call   801048c0 <argstr>
8010507c:	85 c0                	test   %eax,%eax
8010507e:	0f 88 d1 00 00 00    	js     80105155 <sys_open+0xf5>
80105084:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105087:	89 44 24 04          	mov    %eax,0x4(%esp)
8010508b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105092:	e8 99 f7 ff ff       	call   80104830 <argint>
80105097:	85 c0                	test   %eax,%eax
80105099:	0f 88 b6 00 00 00    	js     80105155 <sys_open+0xf5>
    return -1;

  begin_op();
8010509f:	e8 6c da ff ff       	call   80102b10 <begin_op>

  if(omode & O_CREATE){
801050a4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801050a8:	0f 85 82 00 00 00    	jne    80105130 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801050ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801050b1:	89 04 24             	mov    %eax,(%esp)
801050b4:	e8 47 ce ff ff       	call   80101f00 <namei>
801050b9:	85 c0                	test   %eax,%eax
801050bb:	89 c6                	mov    %eax,%esi
801050bd:	0f 84 8d 00 00 00    	je     80105150 <sys_open+0xf0>
      end_op();
      return -1;
    }
    ilock(ip);
801050c3:	89 04 24             	mov    %eax,(%esp)
801050c6:	e8 e5 c5 ff ff       	call   801016b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801050cb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801050d0:	0f 84 92 00 00 00    	je     80105168 <sys_open+0x108>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801050d6:	e8 95 bc ff ff       	call   80100d70 <filealloc>
801050db:	85 c0                	test   %eax,%eax
801050dd:	89 c3                	mov    %eax,%ebx
801050df:	0f 84 93 00 00 00    	je     80105178 <sys_open+0x118>
801050e5:	e8 86 f8 ff ff       	call   80104970 <fdalloc>
801050ea:	85 c0                	test   %eax,%eax
801050ec:	89 c7                	mov    %eax,%edi
801050ee:	0f 88 94 00 00 00    	js     80105188 <sys_open+0x128>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801050f4:	89 34 24             	mov    %esi,(%esp)
801050f7:	e8 94 c6 ff ff       	call   80101790 <iunlock>
  end_op();
801050fc:	e8 7f da ff ff       	call   80102b80 <end_op>

  f->type = FD_INODE;
80105101:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105107:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->ip = ip;
8010510a:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
8010510d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80105114:	89 c2                	mov    %eax,%edx
80105116:	83 e2 01             	and    $0x1,%edx
80105119:	83 f2 01             	xor    $0x1,%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010511c:	a8 03                	test   $0x3,%al
  f->readable = !(omode & O_WRONLY);
8010511e:	88 53 08             	mov    %dl,0x8(%ebx)
  return fd;
80105121:	89 f8                	mov    %edi,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105123:	0f 95 43 09          	setne  0x9(%ebx)
}
80105127:	83 c4 2c             	add    $0x2c,%esp
8010512a:	5b                   	pop    %ebx
8010512b:	5e                   	pop    %esi
8010512c:	5f                   	pop    %edi
8010512d:	5d                   	pop    %ebp
8010512e:	c3                   	ret    
8010512f:	90                   	nop
    ip = create(path, T_FILE, 0, 0);
80105130:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105133:	31 c9                	xor    %ecx,%ecx
80105135:	ba 02 00 00 00       	mov    $0x2,%edx
8010513a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105141:	e8 6a f8 ff ff       	call   801049b0 <create>
    if(ip == 0){
80105146:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105148:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010514a:	75 8a                	jne    801050d6 <sys_open+0x76>
8010514c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105150:	e8 2b da ff ff       	call   80102b80 <end_op>
}
80105155:	83 c4 2c             	add    $0x2c,%esp
    return -1;
80105158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010515d:	5b                   	pop    %ebx
8010515e:	5e                   	pop    %esi
8010515f:	5f                   	pop    %edi
80105160:	5d                   	pop    %ebp
80105161:	c3                   	ret    
80105162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105168:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010516b:	85 c0                	test   %eax,%eax
8010516d:	0f 84 63 ff ff ff    	je     801050d6 <sys_open+0x76>
80105173:	90                   	nop
80105174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105178:	89 34 24             	mov    %esi,(%esp)
8010517b:	e8 90 c7 ff ff       	call   80101910 <iunlockput>
80105180:	eb ce                	jmp    80105150 <sys_open+0xf0>
80105182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      fileclose(f);
80105188:	89 1c 24             	mov    %ebx,(%esp)
8010518b:	e8 a0 bc ff ff       	call   80100e30 <fileclose>
80105190:	eb e6                	jmp    80105178 <sys_open+0x118>
80105192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051a0 <sys_mkdir>:

int
sys_mkdir(void)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801051a6:	e8 65 d9 ff ff       	call   80102b10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801051ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801051b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051b9:	e8 02 f7 ff ff       	call   801048c0 <argstr>
801051be:	85 c0                	test   %eax,%eax
801051c0:	78 2e                	js     801051f0 <sys_mkdir+0x50>
801051c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051c5:	31 c9                	xor    %ecx,%ecx
801051c7:	ba 01 00 00 00       	mov    $0x1,%edx
801051cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051d3:	e8 d8 f7 ff ff       	call   801049b0 <create>
801051d8:	85 c0                	test   %eax,%eax
801051da:	74 14                	je     801051f0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801051dc:	89 04 24             	mov    %eax,(%esp)
801051df:	e8 2c c7 ff ff       	call   80101910 <iunlockput>
  end_op();
801051e4:	e8 97 d9 ff ff       	call   80102b80 <end_op>
  return 0;
801051e9:	31 c0                	xor    %eax,%eax
}
801051eb:	c9                   	leave  
801051ec:	c3                   	ret    
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801051f0:	e8 8b d9 ff ff       	call   80102b80 <end_op>
    return -1;
801051f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051fa:	c9                   	leave  
801051fb:	c3                   	ret    
801051fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105200 <sys_mknod>:

int
sys_mknod(void)
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105206:	e8 05 d9 ff ff       	call   80102b10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010520b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010520e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105212:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105219:	e8 a2 f6 ff ff       	call   801048c0 <argstr>
8010521e:	85 c0                	test   %eax,%eax
80105220:	78 5e                	js     80105280 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105222:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105225:	89 44 24 04          	mov    %eax,0x4(%esp)
80105229:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105230:	e8 fb f5 ff ff       	call   80104830 <argint>
  if((argstr(0, &path)) < 0 ||
80105235:	85 c0                	test   %eax,%eax
80105237:	78 47                	js     80105280 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105239:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010523c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105240:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105247:	e8 e4 f5 ff ff       	call   80104830 <argint>
     argint(1, &major) < 0 ||
8010524c:	85 c0                	test   %eax,%eax
8010524e:	78 30                	js     80105280 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105250:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105254:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80105259:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010525d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80105260:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105263:	e8 48 f7 ff ff       	call   801049b0 <create>
80105268:	85 c0                	test   %eax,%eax
8010526a:	74 14                	je     80105280 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010526c:	89 04 24             	mov    %eax,(%esp)
8010526f:	e8 9c c6 ff ff       	call   80101910 <iunlockput>
  end_op();
80105274:	e8 07 d9 ff ff       	call   80102b80 <end_op>
  return 0;
80105279:	31 c0                	xor    %eax,%eax
}
8010527b:	c9                   	leave  
8010527c:	c3                   	ret    
8010527d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105280:	e8 fb d8 ff ff       	call   80102b80 <end_op>
    return -1;
80105285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010528a:	c9                   	leave  
8010528b:	c3                   	ret    
8010528c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105290 <sys_chdir>:

int
sys_chdir(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	56                   	push   %esi
80105294:	53                   	push   %ebx
80105295:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105298:	e8 53 e4 ff ff       	call   801036f0 <myproc>
8010529d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010529f:	e8 6c d8 ff ff       	call   80102b10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801052a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801052ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801052b2:	e8 09 f6 ff ff       	call   801048c0 <argstr>
801052b7:	85 c0                	test   %eax,%eax
801052b9:	78 4a                	js     80105305 <sys_chdir+0x75>
801052bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052be:	89 04 24             	mov    %eax,(%esp)
801052c1:	e8 3a cc ff ff       	call   80101f00 <namei>
801052c6:	85 c0                	test   %eax,%eax
801052c8:	89 c3                	mov    %eax,%ebx
801052ca:	74 39                	je     80105305 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
801052cc:	89 04 24             	mov    %eax,(%esp)
801052cf:	e8 dc c3 ff ff       	call   801016b0 <ilock>
  if(ip->type != T_DIR){
801052d4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
801052d9:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
801052dc:	75 22                	jne    80105300 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
801052de:	e8 ad c4 ff ff       	call   80101790 <iunlock>
  iput(curproc->cwd);
801052e3:	8b 46 68             	mov    0x68(%esi),%eax
801052e6:	89 04 24             	mov    %eax,(%esp)
801052e9:	e8 e2 c4 ff ff       	call   801017d0 <iput>
  end_op();
801052ee:	e8 8d d8 ff ff       	call   80102b80 <end_op>
  curproc->cwd = ip;
  return 0;
801052f3:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
801052f5:	89 5e 68             	mov    %ebx,0x68(%esi)
}
801052f8:	83 c4 20             	add    $0x20,%esp
801052fb:	5b                   	pop    %ebx
801052fc:	5e                   	pop    %esi
801052fd:	5d                   	pop    %ebp
801052fe:	c3                   	ret    
801052ff:	90                   	nop
    iunlockput(ip);
80105300:	e8 0b c6 ff ff       	call   80101910 <iunlockput>
    end_op();
80105305:	e8 76 d8 ff ff       	call   80102b80 <end_op>
}
8010530a:	83 c4 20             	add    $0x20,%esp
    return -1;
8010530d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105312:	5b                   	pop    %ebx
80105313:	5e                   	pop    %esi
80105314:	5d                   	pop    %ebp
80105315:	c3                   	ret    
80105316:	8d 76 00             	lea    0x0(%esi),%esi
80105319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105320 <sys_exec>:

int
sys_exec(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	57                   	push   %edi
80105324:	56                   	push   %esi
80105325:	53                   	push   %ebx
80105326:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010532c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105332:	89 44 24 04          	mov    %eax,0x4(%esp)
80105336:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010533d:	e8 7e f5 ff ff       	call   801048c0 <argstr>
80105342:	85 c0                	test   %eax,%eax
80105344:	0f 88 84 00 00 00    	js     801053ce <sys_exec+0xae>
8010534a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105350:	89 44 24 04          	mov    %eax,0x4(%esp)
80105354:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010535b:	e8 d0 f4 ff ff       	call   80104830 <argint>
80105360:	85 c0                	test   %eax,%eax
80105362:	78 6a                	js     801053ce <sys_exec+0xae>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105364:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010536a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010536c:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80105373:	00 
80105374:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
8010537a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105381:	00 
80105382:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105388:	89 04 24             	mov    %eax,(%esp)
8010538b:	e8 b0 f1 ff ff       	call   80104540 <memset>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105390:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105396:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010539a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010539d:	89 04 24             	mov    %eax,(%esp)
801053a0:	e8 eb f3 ff ff       	call   80104790 <fetchint>
801053a5:	85 c0                	test   %eax,%eax
801053a7:	78 25                	js     801053ce <sys_exec+0xae>
      return -1;
    if(uarg == 0){
801053a9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801053af:	85 c0                	test   %eax,%eax
801053b1:	74 2d                	je     801053e0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801053b3:	89 74 24 04          	mov    %esi,0x4(%esp)
801053b7:	89 04 24             	mov    %eax,(%esp)
801053ba:	e8 11 f4 ff ff       	call   801047d0 <fetchstr>
801053bf:	85 c0                	test   %eax,%eax
801053c1:	78 0b                	js     801053ce <sys_exec+0xae>
  for(i=0;; i++){
801053c3:	83 c3 01             	add    $0x1,%ebx
801053c6:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801053c9:	83 fb 20             	cmp    $0x20,%ebx
801053cc:	75 c2                	jne    80105390 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
801053ce:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
801053d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053d9:	5b                   	pop    %ebx
801053da:	5e                   	pop    %esi
801053db:	5f                   	pop    %edi
801053dc:	5d                   	pop    %ebp
801053dd:	c3                   	ret    
801053de:	66 90                	xchg   %ax,%ax
  return exec(path, argv);
801053e0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801053e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ea:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
      argv[i] = 0;
801053f0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801053f7:	00 00 00 00 
  return exec(path, argv);
801053fb:	89 04 24             	mov    %eax,(%esp)
801053fe:	e8 9d b5 ff ff       	call   801009a0 <exec>
}
80105403:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105409:	5b                   	pop    %ebx
8010540a:	5e                   	pop    %esi
8010540b:	5f                   	pop    %edi
8010540c:	5d                   	pop    %ebp
8010540d:	c3                   	ret    
8010540e:	66 90                	xchg   %ax,%ax

80105410 <sys_pipe>:

int
sys_pipe(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	53                   	push   %ebx
80105414:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105417:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010541a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105421:	00 
80105422:	89 44 24 04          	mov    %eax,0x4(%esp)
80105426:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010542d:	e8 2e f4 ff ff       	call   80104860 <argptr>
80105432:	85 c0                	test   %eax,%eax
80105434:	78 6d                	js     801054a3 <sys_pipe+0x93>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105436:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105439:	89 44 24 04          	mov    %eax,0x4(%esp)
8010543d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105440:	89 04 24             	mov    %eax,(%esp)
80105443:	e8 28 dd ff ff       	call   80103170 <pipealloc>
80105448:	85 c0                	test   %eax,%eax
8010544a:	78 57                	js     801054a3 <sys_pipe+0x93>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010544c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010544f:	e8 1c f5 ff ff       	call   80104970 <fdalloc>
80105454:	85 c0                	test   %eax,%eax
80105456:	89 c3                	mov    %eax,%ebx
80105458:	78 33                	js     8010548d <sys_pipe+0x7d>
8010545a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010545d:	e8 0e f5 ff ff       	call   80104970 <fdalloc>
80105462:	85 c0                	test   %eax,%eax
80105464:	78 1a                	js     80105480 <sys_pipe+0x70>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105466:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105469:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
8010546b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010546e:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
80105471:	83 c4 24             	add    $0x24,%esp
  return 0;
80105474:	31 c0                	xor    %eax,%eax
}
80105476:	5b                   	pop    %ebx
80105477:	5d                   	pop    %ebp
80105478:	c3                   	ret    
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105480:	e8 6b e2 ff ff       	call   801036f0 <myproc>
80105485:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
8010548c:	00 
    fileclose(rf);
8010548d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105490:	89 04 24             	mov    %eax,(%esp)
80105493:	e8 98 b9 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80105498:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010549b:	89 04 24             	mov    %eax,(%esp)
8010549e:	e8 8d b9 ff ff       	call   80100e30 <fileclose>
}
801054a3:	83 c4 24             	add    $0x24,%esp
    return -1;
801054a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054ab:	5b                   	pop    %ebx
801054ac:	5d                   	pop    %ebp
801054ad:	c3                   	ret    
801054ae:	66 90                	xchg   %ax,%ax

801054b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801054b3:	5d                   	pop    %ebp
  return fork();
801054b4:	e9 e7 e3 ff ff       	jmp    801038a0 <fork>
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_exit>:

int
sys_exit(void) 
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 28             	sub    $0x28,%esp
	int status;

	if(argint(0, &status) < 0) { //if status < 0, fail and return -1
801054c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801054cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054d4:	e8 57 f3 ff ff       	call   80104830 <argint>
801054d9:	85 c0                	test   %eax,%eax
801054db:	78 13                	js     801054f0 <sys_exit+0x30>
		return -1;
	}
	exit(status);
801054dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054e0:	89 04 24             	mov    %eax,(%esp)
801054e3:	e8 b8 e6 ff ff       	call   80103ba0 <exit>
  return 0;  // not reached
801054e8:	31 c0                	xor    %eax,%eax
}
801054ea:	c9                   	leave  
801054eb:	c3                   	ret    
801054ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return -1;
801054f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f5:	c9                   	leave  
801054f6:	c3                   	ret    
801054f7:	89 f6                	mov    %esi,%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105500 <sys_wait>:

int
sys_wait(void)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 28             	sub    $0x28,%esp
	int *status;
	if(argptr(0, (void*)&status, sizeof(status)) < 0) {
80105506:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105509:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105510:	00 
80105511:	89 44 24 04          	mov    %eax,0x4(%esp)
80105515:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010551c:	e8 3f f3 ff ff       	call   80104860 <argptr>
80105521:	85 c0                	test   %eax,%eax
80105523:	78 13                	js     80105538 <sys_wait+0x38>
		return -1;
	}
  return wait(status);
80105525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105528:	89 04 24             	mov    %eax,(%esp)
8010552b:	e8 d0 e8 ff ff       	call   80103e00 <wait>
}
80105530:	c9                   	leave  
80105531:	c3                   	ret    
80105532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return -1;
80105538:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010553d:	c9                   	leave  
8010553e:	c3                   	ret    
8010553f:	90                   	nop

80105540 <sys_waitpid>:

int
sys_waitpid(void) //new for lab1
{      
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	83 ec 28             	sub    $0x28,%esp
	int pid; 
        int *status;
	int options;

	if(argint(0, &pid) < 0) {
80105546:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105549:	89 44 24 04          	mov    %eax,0x4(%esp)
8010554d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105554:	e8 d7 f2 ff ff       	call   80104830 <argint>
80105559:	85 c0                	test   %eax,%eax
8010555b:	78 53                	js     801055b0 <sys_waitpid+0x70>
		return -1;
	}

        if(argptr(1, (void*)&status, sizeof(status)) < 0) {
8010555d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105560:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105567:	00 
80105568:	89 44 24 04          	mov    %eax,0x4(%esp)
8010556c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105573:	e8 e8 f2 ff ff       	call   80104860 <argptr>
80105578:	85 c0                	test   %eax,%eax
8010557a:	78 34                	js     801055b0 <sys_waitpid+0x70>
                return -1;
        }

	if(argint(2, &options) < 0) {
8010557c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010557f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105583:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010558a:	e8 a1 f2 ff ff       	call   80104830 <argint>
8010558f:	85 c0                	test   %eax,%eax
80105591:	78 1d                	js     801055b0 <sys_waitpid+0x70>
		return -1;
	}

	return waitpid(pid, status, options);
80105593:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105596:	89 44 24 08          	mov    %eax,0x8(%esp)
8010559a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010559d:	89 44 24 04          	mov    %eax,0x4(%esp)
801055a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801055a4:	89 04 24             	mov    %eax,(%esp)
801055a7:	e8 44 e9 ff ff       	call   80103ef0 <waitpid>
}
801055ac:	c9                   	leave  
801055ad:	c3                   	ret    
801055ae:	66 90                	xchg   %ax,%ax
		return -1;
801055b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055b5:	c9                   	leave  
801055b6:	c3                   	ret    
801055b7:	89 f6                	mov    %esi,%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055c0 <sys_set_prior>:

int
sys_set_prior(void) //new for lab2
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	83 ec 28             	sub    $0x28,%esp
	int prior_lvl;
	if(argint(0, &prior_lvl) < 0) {
801055c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801055cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801055d4:	e8 57 f2 ff ff       	call   80104830 <argint>
801055d9:	85 c0                	test   %eax,%eax
801055db:	78 13                	js     801055f0 <sys_set_prior+0x30>
		return -1;
	}

	return set_prior(prior_lvl);
801055dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e0:	89 04 24             	mov    %eax,(%esp)
801055e3:	e8 a8 e4 ff ff       	call   80103a90 <set_prior>
}
801055e8:	c9                   	leave  
801055e9:	c3                   	ret    
801055ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return -1;
801055f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055f5:	c9                   	leave  
801055f6:	c3                   	ret    
801055f7:	89 f6                	mov    %esi,%esi
801055f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105600 <sys_kill>:


int
sys_kill(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105606:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105609:	89 44 24 04          	mov    %eax,0x4(%esp)
8010560d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105614:	e8 17 f2 ff ff       	call   80104830 <argint>
80105619:	85 c0                	test   %eax,%eax
8010561b:	78 13                	js     80105630 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010561d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105620:	89 04 24             	mov    %eax,(%esp)
80105623:	e8 48 ea ff ff       	call   80104070 <kill>
}
80105628:	c9                   	leave  
80105629:	c3                   	ret    
8010562a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105635:	c9                   	leave  
80105636:	c3                   	ret    
80105637:	89 f6                	mov    %esi,%esi
80105639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105640 <sys_getpid>:

int
sys_getpid(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105646:	e8 a5 e0 ff ff       	call   801036f0 <myproc>
8010564b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010564e:	c9                   	leave  
8010564f:	c3                   	ret    

80105650 <sys_sbrk>:

int
sys_sbrk(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	53                   	push   %ebx
80105654:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105657:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010565a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010565e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105665:	e8 c6 f1 ff ff       	call   80104830 <argint>
8010566a:	85 c0                	test   %eax,%eax
8010566c:	78 22                	js     80105690 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010566e:	e8 7d e0 ff ff       	call   801036f0 <myproc>
  if(growproc(n) < 0)
80105673:	8b 55 f4             	mov    -0xc(%ebp),%edx
  addr = myproc()->sz;
80105676:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105678:	89 14 24             	mov    %edx,(%esp)
8010567b:	e8 b0 e1 ff ff       	call   80103830 <growproc>
80105680:	85 c0                	test   %eax,%eax
80105682:	78 0c                	js     80105690 <sys_sbrk+0x40>
    return -1;
  return addr;
80105684:	89 d8                	mov    %ebx,%eax
}
80105686:	83 c4 24             	add    $0x24,%esp
80105689:	5b                   	pop    %ebx
8010568a:	5d                   	pop    %ebp
8010568b:	c3                   	ret    
8010568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105690:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105695:	eb ef                	jmp    80105686 <sys_sbrk+0x36>
80105697:	89 f6                	mov    %esi,%esi
80105699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056a0 <sys_sleep>:

int
sys_sleep(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	53                   	push   %ebx
801056a4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801056a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801056ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056b5:	e8 76 f1 ff ff       	call   80104830 <argint>
801056ba:	85 c0                	test   %eax,%eax
801056bc:	78 7e                	js     8010573c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
801056be:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
801056c5:	e8 b6 ed ff ff       	call   80104480 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801056ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801056cd:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  while(ticks - ticks0 < n){
801056d3:	85 d2                	test   %edx,%edx
801056d5:	75 29                	jne    80105700 <sys_sleep+0x60>
801056d7:	eb 4f                	jmp    80105728 <sys_sleep+0x88>
801056d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801056e0:	c7 44 24 04 60 50 11 	movl   $0x80115060,0x4(%esp)
801056e7:	80 
801056e8:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
801056ef:	e8 5c e6 ff ff       	call   80103d50 <sleep>
  while(ticks - ticks0 < n){
801056f4:	a1 a0 58 11 80       	mov    0x801158a0,%eax
801056f9:	29 d8                	sub    %ebx,%eax
801056fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801056fe:	73 28                	jae    80105728 <sys_sleep+0x88>
    if(myproc()->killed){
80105700:	e8 eb df ff ff       	call   801036f0 <myproc>
80105705:	8b 40 24             	mov    0x24(%eax),%eax
80105708:	85 c0                	test   %eax,%eax
8010570a:	74 d4                	je     801056e0 <sys_sleep+0x40>
      release(&tickslock);
8010570c:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105713:	e8 d8 ed ff ff       	call   801044f0 <release>
      return -1;
80105718:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
8010571d:	83 c4 24             	add    $0x24,%esp
80105720:	5b                   	pop    %ebx
80105721:	5d                   	pop    %ebp
80105722:	c3                   	ret    
80105723:	90                   	nop
80105724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80105728:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
8010572f:	e8 bc ed ff ff       	call   801044f0 <release>
}
80105734:	83 c4 24             	add    $0x24,%esp
  return 0;
80105737:	31 c0                	xor    %eax,%eax
}
80105739:	5b                   	pop    %ebx
8010573a:	5d                   	pop    %ebp
8010573b:	c3                   	ret    
    return -1;
8010573c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105741:	eb da                	jmp    8010571d <sys_sleep+0x7d>
80105743:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105750 <sys_hello>:

int
sys_hello(void) {
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 08             	sub    $0x8,%esp
	hello();
80105756:	e8 65 ea ff ff       	call   801041c0 <hello>
	return 0;
} //new for lab1
8010575b:	31 c0                	xor    %eax,%eax
8010575d:	c9                   	leave  
8010575e:	c3                   	ret    
8010575f:	90                   	nop

80105760 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	53                   	push   %ebx
80105764:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105767:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
8010576e:	e8 0d ed ff ff       	call   80104480 <acquire>
  xticks = ticks;
80105773:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  release(&tickslock);
80105779:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105780:	e8 6b ed ff ff       	call   801044f0 <release>
  return xticks;
}
80105785:	83 c4 14             	add    $0x14,%esp
80105788:	89 d8                	mov    %ebx,%eax
8010578a:	5b                   	pop    %ebx
8010578b:	5d                   	pop    %ebp
8010578c:	c3                   	ret    

8010578d <alltraps>:
8010578d:	1e                   	push   %ds
8010578e:	06                   	push   %es
8010578f:	0f a0                	push   %fs
80105791:	0f a8                	push   %gs
80105793:	60                   	pusha  
80105794:	66 b8 10 00          	mov    $0x10,%ax
80105798:	8e d8                	mov    %eax,%ds
8010579a:	8e c0                	mov    %eax,%es
8010579c:	54                   	push   %esp
8010579d:	e8 de 00 00 00       	call   80105880 <trap>
801057a2:	83 c4 04             	add    $0x4,%esp

801057a5 <trapret>:
801057a5:	61                   	popa   
801057a6:	0f a9                	pop    %gs
801057a8:	0f a1                	pop    %fs
801057aa:	07                   	pop    %es
801057ab:	1f                   	pop    %ds
801057ac:	83 c4 08             	add    $0x8,%esp
801057af:	cf                   	iret   

801057b0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801057b0:	31 c0                	xor    %eax,%eax
801057b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801057b8:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801057bf:	b9 08 00 00 00       	mov    $0x8,%ecx
801057c4:	66 89 0c c5 a2 50 11 	mov    %cx,-0x7feeaf5e(,%eax,8)
801057cb:	80 
801057cc:	c6 04 c5 a4 50 11 80 	movb   $0x0,-0x7feeaf5c(,%eax,8)
801057d3:	00 
801057d4:	c6 04 c5 a5 50 11 80 	movb   $0x8e,-0x7feeaf5b(,%eax,8)
801057db:	8e 
801057dc:	66 89 14 c5 a0 50 11 	mov    %dx,-0x7feeaf60(,%eax,8)
801057e3:	80 
801057e4:	c1 ea 10             	shr    $0x10,%edx
801057e7:	66 89 14 c5 a6 50 11 	mov    %dx,-0x7feeaf5a(,%eax,8)
801057ee:	80 
  for(i = 0; i < 256; i++)
801057ef:	83 c0 01             	add    $0x1,%eax
801057f2:	3d 00 01 00 00       	cmp    $0x100,%eax
801057f7:	75 bf                	jne    801057b8 <tvinit+0x8>
{
801057f9:	55                   	push   %ebp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801057fa:	ba 08 00 00 00       	mov    $0x8,%edx
{
801057ff:	89 e5                	mov    %esp,%ebp
80105801:	83 ec 18             	sub    $0x18,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105804:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105809:	c7 44 24 04 c5 77 10 	movl   $0x801077c5,0x4(%esp)
80105810:	80 
80105811:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105818:	66 89 15 a2 52 11 80 	mov    %dx,0x801152a2
8010581f:	66 a3 a0 52 11 80    	mov    %ax,0x801152a0
80105825:	c1 e8 10             	shr    $0x10,%eax
80105828:	c6 05 a4 52 11 80 00 	movb   $0x0,0x801152a4
8010582f:	c6 05 a5 52 11 80 ef 	movb   $0xef,0x801152a5
80105836:	66 a3 a6 52 11 80    	mov    %ax,0x801152a6
  initlock(&tickslock, "time");
8010583c:	e8 cf ea ff ff       	call   80104310 <initlock>
}
80105841:	c9                   	leave  
80105842:	c3                   	ret    
80105843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105850 <idtinit>:

void
idtinit(void)
{
80105850:	55                   	push   %ebp
  pd[0] = size-1;
80105851:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105856:	89 e5                	mov    %esp,%ebp
80105858:	83 ec 10             	sub    $0x10,%esp
8010585b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010585f:	b8 a0 50 11 80       	mov    $0x801150a0,%eax
80105864:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105868:	c1 e8 10             	shr    $0x10,%eax
8010586b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010586f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105872:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105875:	c9                   	leave  
80105876:	c3                   	ret    
80105877:	89 f6                	mov    %esi,%esi
80105879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105880 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	57                   	push   %edi
80105884:	56                   	push   %esi
80105885:	53                   	push   %ebx
80105886:	83 ec 3c             	sub    $0x3c,%esp
80105889:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010588c:	8b 43 30             	mov    0x30(%ebx),%eax
8010588f:	83 f8 40             	cmp    $0x40,%eax
80105892:	0f 84 a0 01 00 00    	je     80105a38 <trap+0x1b8>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80105898:	83 e8 20             	sub    $0x20,%eax
8010589b:	83 f8 1f             	cmp    $0x1f,%eax
8010589e:	77 08                	ja     801058a8 <trap+0x28>
801058a0:	ff 24 85 6c 78 10 80 	jmp    *-0x7fef8794(,%eax,4)
801058a7:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801058a8:	e8 43 de ff ff       	call   801036f0 <myproc>
801058ad:	85 c0                	test   %eax,%eax
801058af:	90                   	nop
801058b0:	0f 84 0a 02 00 00    	je     80105ac0 <trap+0x240>
801058b6:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801058ba:	0f 84 00 02 00 00    	je     80105ac0 <trap+0x240>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801058c0:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801058c3:	8b 53 38             	mov    0x38(%ebx),%edx
801058c6:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801058c9:	89 55 dc             	mov    %edx,-0x24(%ebp)
801058cc:	e8 ff dd ff ff       	call   801036d0 <cpuid>
801058d1:	8b 73 30             	mov    0x30(%ebx),%esi
801058d4:	89 c7                	mov    %eax,%edi
801058d6:	8b 43 34             	mov    0x34(%ebx),%eax
801058d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801058dc:	e8 0f de ff ff       	call   801036f0 <myproc>
801058e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
801058e4:	e8 07 de ff ff       	call   801036f0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801058e9:	8b 55 dc             	mov    -0x24(%ebp),%edx
801058ec:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
801058f0:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801058f3:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801058f6:	89 7c 24 14          	mov    %edi,0x14(%esp)
801058fa:	89 54 24 18          	mov    %edx,0x18(%esp)
801058fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80105901:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105904:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105908:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010590c:	89 54 24 10          	mov    %edx,0x10(%esp)
80105910:	8b 40 10             	mov    0x10(%eax),%eax
80105913:	c7 04 24 28 78 10 80 	movl   $0x80107828,(%esp)
8010591a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010591e:	e8 2d ad ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105923:	e8 c8 dd ff ff       	call   801036f0 <myproc>
80105928:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010592f:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105930:	e8 bb dd ff ff       	call   801036f0 <myproc>
80105935:	85 c0                	test   %eax,%eax
80105937:	74 0c                	je     80105945 <trap+0xc5>
80105939:	e8 b2 dd ff ff       	call   801036f0 <myproc>
8010593e:	8b 50 24             	mov    0x24(%eax),%edx
80105941:	85 d2                	test   %edx,%edx
80105943:	75 4b                	jne    80105990 <trap+0x110>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105945:	e8 a6 dd ff ff       	call   801036f0 <myproc>
8010594a:	85 c0                	test   %eax,%eax
8010594c:	74 0d                	je     8010595b <trap+0xdb>
8010594e:	66 90                	xchg   %ax,%ax
80105950:	e8 9b dd ff ff       	call   801036f0 <myproc>
80105955:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105959:	74 55                	je     801059b0 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010595b:	e8 90 dd ff ff       	call   801036f0 <myproc>
80105960:	85 c0                	test   %eax,%eax
80105962:	74 1d                	je     80105981 <trap+0x101>
80105964:	e8 87 dd ff ff       	call   801036f0 <myproc>
80105969:	8b 40 24             	mov    0x24(%eax),%eax
8010596c:	85 c0                	test   %eax,%eax
8010596e:	74 11                	je     80105981 <trap+0x101>
80105970:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105974:	83 e0 03             	and    $0x3,%eax
80105977:	66 83 f8 03          	cmp    $0x3,%ax
8010597b:	0f 84 e8 00 00 00    	je     80105a69 <trap+0x1e9>
    exit(0);
}
80105981:	83 c4 3c             	add    $0x3c,%esp
80105984:	5b                   	pop    %ebx
80105985:	5e                   	pop    %esi
80105986:	5f                   	pop    %edi
80105987:	5d                   	pop    %ebp
80105988:	c3                   	ret    
80105989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105990:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105994:	83 e0 03             	and    $0x3,%eax
80105997:	66 83 f8 03          	cmp    $0x3,%ax
8010599b:	75 a8                	jne    80105945 <trap+0xc5>
    exit(0);
8010599d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801059a4:	e8 f7 e1 ff ff       	call   80103ba0 <exit>
801059a9:	eb 9a                	jmp    80105945 <trap+0xc5>
801059ab:	90                   	nop
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
801059b0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801059b4:	75 a5                	jne    8010595b <trap+0xdb>
    yield();
801059b6:	e8 55 e3 ff ff       	call   80103d10 <yield>
801059bb:	eb 9e                	jmp    8010595b <trap+0xdb>
801059bd:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
801059c0:	e8 0b dd ff ff       	call   801036d0 <cpuid>
801059c5:	85 c0                	test   %eax,%eax
801059c7:	0f 84 c3 00 00 00    	je     80105a90 <trap+0x210>
801059cd:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
801059d0:	e8 ab cd ff ff       	call   80102780 <lapiceoi>
    break;
801059d5:	e9 56 ff ff ff       	jmp    80105930 <trap+0xb0>
801059da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kbdintr();
801059e0:	e8 eb cb ff ff       	call   801025d0 <kbdintr>
    lapiceoi();
801059e5:	e8 96 cd ff ff       	call   80102780 <lapiceoi>
    break;
801059ea:	e9 41 ff ff ff       	jmp    80105930 <trap+0xb0>
801059ef:	90                   	nop
    uartintr();
801059f0:	e8 2b 02 00 00       	call   80105c20 <uartintr>
    lapiceoi();
801059f5:	e8 86 cd ff ff       	call   80102780 <lapiceoi>
    break;
801059fa:	e9 31 ff ff ff       	jmp    80105930 <trap+0xb0>
801059ff:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105a00:	8b 7b 38             	mov    0x38(%ebx),%edi
80105a03:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105a07:	e8 c4 dc ff ff       	call   801036d0 <cpuid>
80105a0c:	c7 04 24 d0 77 10 80 	movl   $0x801077d0,(%esp)
80105a13:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105a17:	89 74 24 08          	mov    %esi,0x8(%esp)
80105a1b:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a1f:	e8 2c ac ff ff       	call   80100650 <cprintf>
    lapiceoi();
80105a24:	e8 57 cd ff ff       	call   80102780 <lapiceoi>
    break;
80105a29:	e9 02 ff ff ff       	jmp    80105930 <trap+0xb0>
80105a2e:	66 90                	xchg   %ax,%ax
    ideintr();
80105a30:	e8 4b c6 ff ff       	call   80102080 <ideintr>
80105a35:	eb 96                	jmp    801059cd <trap+0x14d>
80105a37:	90                   	nop
80105a38:	90                   	nop
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105a40:	e8 ab dc ff ff       	call   801036f0 <myproc>
80105a45:	8b 70 24             	mov    0x24(%eax),%esi
80105a48:	85 f6                	test   %esi,%esi
80105a4a:	75 34                	jne    80105a80 <trap+0x200>
    myproc()->tf = tf;
80105a4c:	e8 9f dc ff ff       	call   801036f0 <myproc>
80105a51:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105a54:	e8 a7 ee ff ff       	call   80104900 <syscall>
    if(myproc()->killed)
80105a59:	e8 92 dc ff ff       	call   801036f0 <myproc>
80105a5e:	8b 48 24             	mov    0x24(%eax),%ecx
80105a61:	85 c9                	test   %ecx,%ecx
80105a63:	0f 84 18 ff ff ff    	je     80105981 <trap+0x101>
      exit(0);
80105a69:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80105a70:	83 c4 3c             	add    $0x3c,%esp
80105a73:	5b                   	pop    %ebx
80105a74:	5e                   	pop    %esi
80105a75:	5f                   	pop    %edi
80105a76:	5d                   	pop    %ebp
      exit(0);
80105a77:	e9 24 e1 ff ff       	jmp    80103ba0 <exit>
80105a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit(0);
80105a80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105a87:	e8 14 e1 ff ff       	call   80103ba0 <exit>
80105a8c:	eb be                	jmp    80105a4c <trap+0x1cc>
80105a8e:	66 90                	xchg   %ax,%ax
      acquire(&tickslock);
80105a90:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105a97:	e8 e4 e9 ff ff       	call   80104480 <acquire>
      wakeup(&ticks);
80105a9c:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
      ticks++;
80105aa3:	83 05 a0 58 11 80 01 	addl   $0x1,0x801158a0
      wakeup(&ticks);
80105aaa:	e8 51 e5 ff ff       	call   80104000 <wakeup>
      release(&tickslock);
80105aaf:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105ab6:	e8 35 ea ff ff       	call   801044f0 <release>
80105abb:	e9 0d ff ff ff       	jmp    801059cd <trap+0x14d>
80105ac0:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105ac3:	8b 73 38             	mov    0x38(%ebx),%esi
80105ac6:	e8 05 dc ff ff       	call   801036d0 <cpuid>
80105acb:	89 7c 24 10          	mov    %edi,0x10(%esp)
80105acf:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105ad3:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ad7:	8b 43 30             	mov    0x30(%ebx),%eax
80105ada:	c7 04 24 f4 77 10 80 	movl   $0x801077f4,(%esp)
80105ae1:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ae5:	e8 66 ab ff ff       	call   80100650 <cprintf>
      panic("trap");
80105aea:	c7 04 24 ca 77 10 80 	movl   $0x801077ca,(%esp)
80105af1:	e8 6a a8 ff ff       	call   80100360 <panic>
80105af6:	66 90                	xchg   %ax,%ax
80105af8:	66 90                	xchg   %ax,%ax
80105afa:	66 90                	xchg   %ax,%ax
80105afc:	66 90                	xchg   %ax,%ax
80105afe:	66 90                	xchg   %ax,%ax

80105b00 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b00:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105b05:	55                   	push   %ebp
80105b06:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b08:	85 c0                	test   %eax,%eax
80105b0a:	74 14                	je     80105b20 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b0c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b11:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b12:	a8 01                	test   $0x1,%al
80105b14:	74 0a                	je     80105b20 <uartgetc+0x20>
80105b16:	b2 f8                	mov    $0xf8,%dl
80105b18:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b19:	0f b6 c0             	movzbl %al,%eax
}
80105b1c:	5d                   	pop    %ebp
80105b1d:	c3                   	ret    
80105b1e:	66 90                	xchg   %ax,%ax
    return -1;
80105b20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b25:	5d                   	pop    %ebp
80105b26:	c3                   	ret    
80105b27:	89 f6                	mov    %esi,%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b30 <uartputc>:
  if(!uart)
80105b30:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105b35:	85 c0                	test   %eax,%eax
80105b37:	74 3f                	je     80105b78 <uartputc+0x48>
{
80105b39:	55                   	push   %ebp
80105b3a:	89 e5                	mov    %esp,%ebp
80105b3c:	56                   	push   %esi
80105b3d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105b42:	53                   	push   %ebx
  if(!uart)
80105b43:	bb 80 00 00 00       	mov    $0x80,%ebx
{
80105b48:	83 ec 10             	sub    $0x10,%esp
80105b4b:	eb 14                	jmp    80105b61 <uartputc+0x31>
80105b4d:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105b50:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105b57:	e8 44 cc ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105b5c:	83 eb 01             	sub    $0x1,%ebx
80105b5f:	74 07                	je     80105b68 <uartputc+0x38>
80105b61:	89 f2                	mov    %esi,%edx
80105b63:	ec                   	in     (%dx),%al
80105b64:	a8 20                	test   $0x20,%al
80105b66:	74 e8                	je     80105b50 <uartputc+0x20>
  outb(COM1+0, c);
80105b68:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105b6c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b71:	ee                   	out    %al,(%dx)
}
80105b72:	83 c4 10             	add    $0x10,%esp
80105b75:	5b                   	pop    %ebx
80105b76:	5e                   	pop    %esi
80105b77:	5d                   	pop    %ebp
80105b78:	f3 c3                	repz ret 
80105b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105b80 <uartinit>:
{
80105b80:	55                   	push   %ebp
80105b81:	31 c9                	xor    %ecx,%ecx
80105b83:	89 e5                	mov    %esp,%ebp
80105b85:	89 c8                	mov    %ecx,%eax
80105b87:	57                   	push   %edi
80105b88:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105b8d:	56                   	push   %esi
80105b8e:	89 fa                	mov    %edi,%edx
80105b90:	53                   	push   %ebx
80105b91:	83 ec 1c             	sub    $0x1c,%esp
80105b94:	ee                   	out    %al,(%dx)
80105b95:	be fb 03 00 00       	mov    $0x3fb,%esi
80105b9a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105b9f:	89 f2                	mov    %esi,%edx
80105ba1:	ee                   	out    %al,(%dx)
80105ba2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ba7:	b2 f8                	mov    $0xf8,%dl
80105ba9:	ee                   	out    %al,(%dx)
80105baa:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105baf:	89 c8                	mov    %ecx,%eax
80105bb1:	89 da                	mov    %ebx,%edx
80105bb3:	ee                   	out    %al,(%dx)
80105bb4:	b8 03 00 00 00       	mov    $0x3,%eax
80105bb9:	89 f2                	mov    %esi,%edx
80105bbb:	ee                   	out    %al,(%dx)
80105bbc:	b2 fc                	mov    $0xfc,%dl
80105bbe:	89 c8                	mov    %ecx,%eax
80105bc0:	ee                   	out    %al,(%dx)
80105bc1:	b8 01 00 00 00       	mov    $0x1,%eax
80105bc6:	89 da                	mov    %ebx,%edx
80105bc8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105bc9:	b2 fd                	mov    $0xfd,%dl
80105bcb:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105bcc:	3c ff                	cmp    $0xff,%al
80105bce:	74 42                	je     80105c12 <uartinit+0x92>
  uart = 1;
80105bd0:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105bd7:	00 00 00 
80105bda:	89 fa                	mov    %edi,%edx
80105bdc:	ec                   	in     (%dx),%al
80105bdd:	b2 f8                	mov    $0xf8,%dl
80105bdf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105be0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105be7:	00 
  for(p="xv6...\n"; *p; p++)
80105be8:	bb ec 78 10 80       	mov    $0x801078ec,%ebx
  ioapicenable(IRQ_COM1, 0);
80105bed:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105bf4:	e8 b7 c6 ff ff       	call   801022b0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80105bf9:	b8 78 00 00 00       	mov    $0x78,%eax
80105bfe:	66 90                	xchg   %ax,%ax
    uartputc(*p);
80105c00:	89 04 24             	mov    %eax,(%esp)
  for(p="xv6...\n"; *p; p++)
80105c03:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105c06:	e8 25 ff ff ff       	call   80105b30 <uartputc>
  for(p="xv6...\n"; *p; p++)
80105c0b:	0f be 03             	movsbl (%ebx),%eax
80105c0e:	84 c0                	test   %al,%al
80105c10:	75 ee                	jne    80105c00 <uartinit+0x80>
}
80105c12:	83 c4 1c             	add    $0x1c,%esp
80105c15:	5b                   	pop    %ebx
80105c16:	5e                   	pop    %esi
80105c17:	5f                   	pop    %edi
80105c18:	5d                   	pop    %ebp
80105c19:	c3                   	ret    
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c20 <uartintr>:

void
uartintr(void)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105c26:	c7 04 24 00 5b 10 80 	movl   $0x80105b00,(%esp)
80105c2d:	e8 7e ab ff ff       	call   801007b0 <consoleintr>
}
80105c32:	c9                   	leave  
80105c33:	c3                   	ret    

80105c34 <vector0>:
80105c34:	6a 00                	push   $0x0
80105c36:	6a 00                	push   $0x0
80105c38:	e9 50 fb ff ff       	jmp    8010578d <alltraps>

80105c3d <vector1>:
80105c3d:	6a 00                	push   $0x0
80105c3f:	6a 01                	push   $0x1
80105c41:	e9 47 fb ff ff       	jmp    8010578d <alltraps>

80105c46 <vector2>:
80105c46:	6a 00                	push   $0x0
80105c48:	6a 02                	push   $0x2
80105c4a:	e9 3e fb ff ff       	jmp    8010578d <alltraps>

80105c4f <vector3>:
80105c4f:	6a 00                	push   $0x0
80105c51:	6a 03                	push   $0x3
80105c53:	e9 35 fb ff ff       	jmp    8010578d <alltraps>

80105c58 <vector4>:
80105c58:	6a 00                	push   $0x0
80105c5a:	6a 04                	push   $0x4
80105c5c:	e9 2c fb ff ff       	jmp    8010578d <alltraps>

80105c61 <vector5>:
80105c61:	6a 00                	push   $0x0
80105c63:	6a 05                	push   $0x5
80105c65:	e9 23 fb ff ff       	jmp    8010578d <alltraps>

80105c6a <vector6>:
80105c6a:	6a 00                	push   $0x0
80105c6c:	6a 06                	push   $0x6
80105c6e:	e9 1a fb ff ff       	jmp    8010578d <alltraps>

80105c73 <vector7>:
80105c73:	6a 00                	push   $0x0
80105c75:	6a 07                	push   $0x7
80105c77:	e9 11 fb ff ff       	jmp    8010578d <alltraps>

80105c7c <vector8>:
80105c7c:	6a 08                	push   $0x8
80105c7e:	e9 0a fb ff ff       	jmp    8010578d <alltraps>

80105c83 <vector9>:
80105c83:	6a 00                	push   $0x0
80105c85:	6a 09                	push   $0x9
80105c87:	e9 01 fb ff ff       	jmp    8010578d <alltraps>

80105c8c <vector10>:
80105c8c:	6a 0a                	push   $0xa
80105c8e:	e9 fa fa ff ff       	jmp    8010578d <alltraps>

80105c93 <vector11>:
80105c93:	6a 0b                	push   $0xb
80105c95:	e9 f3 fa ff ff       	jmp    8010578d <alltraps>

80105c9a <vector12>:
80105c9a:	6a 0c                	push   $0xc
80105c9c:	e9 ec fa ff ff       	jmp    8010578d <alltraps>

80105ca1 <vector13>:
80105ca1:	6a 0d                	push   $0xd
80105ca3:	e9 e5 fa ff ff       	jmp    8010578d <alltraps>

80105ca8 <vector14>:
80105ca8:	6a 0e                	push   $0xe
80105caa:	e9 de fa ff ff       	jmp    8010578d <alltraps>

80105caf <vector15>:
80105caf:	6a 00                	push   $0x0
80105cb1:	6a 0f                	push   $0xf
80105cb3:	e9 d5 fa ff ff       	jmp    8010578d <alltraps>

80105cb8 <vector16>:
80105cb8:	6a 00                	push   $0x0
80105cba:	6a 10                	push   $0x10
80105cbc:	e9 cc fa ff ff       	jmp    8010578d <alltraps>

80105cc1 <vector17>:
80105cc1:	6a 11                	push   $0x11
80105cc3:	e9 c5 fa ff ff       	jmp    8010578d <alltraps>

80105cc8 <vector18>:
80105cc8:	6a 00                	push   $0x0
80105cca:	6a 12                	push   $0x12
80105ccc:	e9 bc fa ff ff       	jmp    8010578d <alltraps>

80105cd1 <vector19>:
80105cd1:	6a 00                	push   $0x0
80105cd3:	6a 13                	push   $0x13
80105cd5:	e9 b3 fa ff ff       	jmp    8010578d <alltraps>

80105cda <vector20>:
80105cda:	6a 00                	push   $0x0
80105cdc:	6a 14                	push   $0x14
80105cde:	e9 aa fa ff ff       	jmp    8010578d <alltraps>

80105ce3 <vector21>:
80105ce3:	6a 00                	push   $0x0
80105ce5:	6a 15                	push   $0x15
80105ce7:	e9 a1 fa ff ff       	jmp    8010578d <alltraps>

80105cec <vector22>:
80105cec:	6a 00                	push   $0x0
80105cee:	6a 16                	push   $0x16
80105cf0:	e9 98 fa ff ff       	jmp    8010578d <alltraps>

80105cf5 <vector23>:
80105cf5:	6a 00                	push   $0x0
80105cf7:	6a 17                	push   $0x17
80105cf9:	e9 8f fa ff ff       	jmp    8010578d <alltraps>

80105cfe <vector24>:
80105cfe:	6a 00                	push   $0x0
80105d00:	6a 18                	push   $0x18
80105d02:	e9 86 fa ff ff       	jmp    8010578d <alltraps>

80105d07 <vector25>:
80105d07:	6a 00                	push   $0x0
80105d09:	6a 19                	push   $0x19
80105d0b:	e9 7d fa ff ff       	jmp    8010578d <alltraps>

80105d10 <vector26>:
80105d10:	6a 00                	push   $0x0
80105d12:	6a 1a                	push   $0x1a
80105d14:	e9 74 fa ff ff       	jmp    8010578d <alltraps>

80105d19 <vector27>:
80105d19:	6a 00                	push   $0x0
80105d1b:	6a 1b                	push   $0x1b
80105d1d:	e9 6b fa ff ff       	jmp    8010578d <alltraps>

80105d22 <vector28>:
80105d22:	6a 00                	push   $0x0
80105d24:	6a 1c                	push   $0x1c
80105d26:	e9 62 fa ff ff       	jmp    8010578d <alltraps>

80105d2b <vector29>:
80105d2b:	6a 00                	push   $0x0
80105d2d:	6a 1d                	push   $0x1d
80105d2f:	e9 59 fa ff ff       	jmp    8010578d <alltraps>

80105d34 <vector30>:
80105d34:	6a 00                	push   $0x0
80105d36:	6a 1e                	push   $0x1e
80105d38:	e9 50 fa ff ff       	jmp    8010578d <alltraps>

80105d3d <vector31>:
80105d3d:	6a 00                	push   $0x0
80105d3f:	6a 1f                	push   $0x1f
80105d41:	e9 47 fa ff ff       	jmp    8010578d <alltraps>

80105d46 <vector32>:
80105d46:	6a 00                	push   $0x0
80105d48:	6a 20                	push   $0x20
80105d4a:	e9 3e fa ff ff       	jmp    8010578d <alltraps>

80105d4f <vector33>:
80105d4f:	6a 00                	push   $0x0
80105d51:	6a 21                	push   $0x21
80105d53:	e9 35 fa ff ff       	jmp    8010578d <alltraps>

80105d58 <vector34>:
80105d58:	6a 00                	push   $0x0
80105d5a:	6a 22                	push   $0x22
80105d5c:	e9 2c fa ff ff       	jmp    8010578d <alltraps>

80105d61 <vector35>:
80105d61:	6a 00                	push   $0x0
80105d63:	6a 23                	push   $0x23
80105d65:	e9 23 fa ff ff       	jmp    8010578d <alltraps>

80105d6a <vector36>:
80105d6a:	6a 00                	push   $0x0
80105d6c:	6a 24                	push   $0x24
80105d6e:	e9 1a fa ff ff       	jmp    8010578d <alltraps>

80105d73 <vector37>:
80105d73:	6a 00                	push   $0x0
80105d75:	6a 25                	push   $0x25
80105d77:	e9 11 fa ff ff       	jmp    8010578d <alltraps>

80105d7c <vector38>:
80105d7c:	6a 00                	push   $0x0
80105d7e:	6a 26                	push   $0x26
80105d80:	e9 08 fa ff ff       	jmp    8010578d <alltraps>

80105d85 <vector39>:
80105d85:	6a 00                	push   $0x0
80105d87:	6a 27                	push   $0x27
80105d89:	e9 ff f9 ff ff       	jmp    8010578d <alltraps>

80105d8e <vector40>:
80105d8e:	6a 00                	push   $0x0
80105d90:	6a 28                	push   $0x28
80105d92:	e9 f6 f9 ff ff       	jmp    8010578d <alltraps>

80105d97 <vector41>:
80105d97:	6a 00                	push   $0x0
80105d99:	6a 29                	push   $0x29
80105d9b:	e9 ed f9 ff ff       	jmp    8010578d <alltraps>

80105da0 <vector42>:
80105da0:	6a 00                	push   $0x0
80105da2:	6a 2a                	push   $0x2a
80105da4:	e9 e4 f9 ff ff       	jmp    8010578d <alltraps>

80105da9 <vector43>:
80105da9:	6a 00                	push   $0x0
80105dab:	6a 2b                	push   $0x2b
80105dad:	e9 db f9 ff ff       	jmp    8010578d <alltraps>

80105db2 <vector44>:
80105db2:	6a 00                	push   $0x0
80105db4:	6a 2c                	push   $0x2c
80105db6:	e9 d2 f9 ff ff       	jmp    8010578d <alltraps>

80105dbb <vector45>:
80105dbb:	6a 00                	push   $0x0
80105dbd:	6a 2d                	push   $0x2d
80105dbf:	e9 c9 f9 ff ff       	jmp    8010578d <alltraps>

80105dc4 <vector46>:
80105dc4:	6a 00                	push   $0x0
80105dc6:	6a 2e                	push   $0x2e
80105dc8:	e9 c0 f9 ff ff       	jmp    8010578d <alltraps>

80105dcd <vector47>:
80105dcd:	6a 00                	push   $0x0
80105dcf:	6a 2f                	push   $0x2f
80105dd1:	e9 b7 f9 ff ff       	jmp    8010578d <alltraps>

80105dd6 <vector48>:
80105dd6:	6a 00                	push   $0x0
80105dd8:	6a 30                	push   $0x30
80105dda:	e9 ae f9 ff ff       	jmp    8010578d <alltraps>

80105ddf <vector49>:
80105ddf:	6a 00                	push   $0x0
80105de1:	6a 31                	push   $0x31
80105de3:	e9 a5 f9 ff ff       	jmp    8010578d <alltraps>

80105de8 <vector50>:
80105de8:	6a 00                	push   $0x0
80105dea:	6a 32                	push   $0x32
80105dec:	e9 9c f9 ff ff       	jmp    8010578d <alltraps>

80105df1 <vector51>:
80105df1:	6a 00                	push   $0x0
80105df3:	6a 33                	push   $0x33
80105df5:	e9 93 f9 ff ff       	jmp    8010578d <alltraps>

80105dfa <vector52>:
80105dfa:	6a 00                	push   $0x0
80105dfc:	6a 34                	push   $0x34
80105dfe:	e9 8a f9 ff ff       	jmp    8010578d <alltraps>

80105e03 <vector53>:
80105e03:	6a 00                	push   $0x0
80105e05:	6a 35                	push   $0x35
80105e07:	e9 81 f9 ff ff       	jmp    8010578d <alltraps>

80105e0c <vector54>:
80105e0c:	6a 00                	push   $0x0
80105e0e:	6a 36                	push   $0x36
80105e10:	e9 78 f9 ff ff       	jmp    8010578d <alltraps>

80105e15 <vector55>:
80105e15:	6a 00                	push   $0x0
80105e17:	6a 37                	push   $0x37
80105e19:	e9 6f f9 ff ff       	jmp    8010578d <alltraps>

80105e1e <vector56>:
80105e1e:	6a 00                	push   $0x0
80105e20:	6a 38                	push   $0x38
80105e22:	e9 66 f9 ff ff       	jmp    8010578d <alltraps>

80105e27 <vector57>:
80105e27:	6a 00                	push   $0x0
80105e29:	6a 39                	push   $0x39
80105e2b:	e9 5d f9 ff ff       	jmp    8010578d <alltraps>

80105e30 <vector58>:
80105e30:	6a 00                	push   $0x0
80105e32:	6a 3a                	push   $0x3a
80105e34:	e9 54 f9 ff ff       	jmp    8010578d <alltraps>

80105e39 <vector59>:
80105e39:	6a 00                	push   $0x0
80105e3b:	6a 3b                	push   $0x3b
80105e3d:	e9 4b f9 ff ff       	jmp    8010578d <alltraps>

80105e42 <vector60>:
80105e42:	6a 00                	push   $0x0
80105e44:	6a 3c                	push   $0x3c
80105e46:	e9 42 f9 ff ff       	jmp    8010578d <alltraps>

80105e4b <vector61>:
80105e4b:	6a 00                	push   $0x0
80105e4d:	6a 3d                	push   $0x3d
80105e4f:	e9 39 f9 ff ff       	jmp    8010578d <alltraps>

80105e54 <vector62>:
80105e54:	6a 00                	push   $0x0
80105e56:	6a 3e                	push   $0x3e
80105e58:	e9 30 f9 ff ff       	jmp    8010578d <alltraps>

80105e5d <vector63>:
80105e5d:	6a 00                	push   $0x0
80105e5f:	6a 3f                	push   $0x3f
80105e61:	e9 27 f9 ff ff       	jmp    8010578d <alltraps>

80105e66 <vector64>:
80105e66:	6a 00                	push   $0x0
80105e68:	6a 40                	push   $0x40
80105e6a:	e9 1e f9 ff ff       	jmp    8010578d <alltraps>

80105e6f <vector65>:
80105e6f:	6a 00                	push   $0x0
80105e71:	6a 41                	push   $0x41
80105e73:	e9 15 f9 ff ff       	jmp    8010578d <alltraps>

80105e78 <vector66>:
80105e78:	6a 00                	push   $0x0
80105e7a:	6a 42                	push   $0x42
80105e7c:	e9 0c f9 ff ff       	jmp    8010578d <alltraps>

80105e81 <vector67>:
80105e81:	6a 00                	push   $0x0
80105e83:	6a 43                	push   $0x43
80105e85:	e9 03 f9 ff ff       	jmp    8010578d <alltraps>

80105e8a <vector68>:
80105e8a:	6a 00                	push   $0x0
80105e8c:	6a 44                	push   $0x44
80105e8e:	e9 fa f8 ff ff       	jmp    8010578d <alltraps>

80105e93 <vector69>:
80105e93:	6a 00                	push   $0x0
80105e95:	6a 45                	push   $0x45
80105e97:	e9 f1 f8 ff ff       	jmp    8010578d <alltraps>

80105e9c <vector70>:
80105e9c:	6a 00                	push   $0x0
80105e9e:	6a 46                	push   $0x46
80105ea0:	e9 e8 f8 ff ff       	jmp    8010578d <alltraps>

80105ea5 <vector71>:
80105ea5:	6a 00                	push   $0x0
80105ea7:	6a 47                	push   $0x47
80105ea9:	e9 df f8 ff ff       	jmp    8010578d <alltraps>

80105eae <vector72>:
80105eae:	6a 00                	push   $0x0
80105eb0:	6a 48                	push   $0x48
80105eb2:	e9 d6 f8 ff ff       	jmp    8010578d <alltraps>

80105eb7 <vector73>:
80105eb7:	6a 00                	push   $0x0
80105eb9:	6a 49                	push   $0x49
80105ebb:	e9 cd f8 ff ff       	jmp    8010578d <alltraps>

80105ec0 <vector74>:
80105ec0:	6a 00                	push   $0x0
80105ec2:	6a 4a                	push   $0x4a
80105ec4:	e9 c4 f8 ff ff       	jmp    8010578d <alltraps>

80105ec9 <vector75>:
80105ec9:	6a 00                	push   $0x0
80105ecb:	6a 4b                	push   $0x4b
80105ecd:	e9 bb f8 ff ff       	jmp    8010578d <alltraps>

80105ed2 <vector76>:
80105ed2:	6a 00                	push   $0x0
80105ed4:	6a 4c                	push   $0x4c
80105ed6:	e9 b2 f8 ff ff       	jmp    8010578d <alltraps>

80105edb <vector77>:
80105edb:	6a 00                	push   $0x0
80105edd:	6a 4d                	push   $0x4d
80105edf:	e9 a9 f8 ff ff       	jmp    8010578d <alltraps>

80105ee4 <vector78>:
80105ee4:	6a 00                	push   $0x0
80105ee6:	6a 4e                	push   $0x4e
80105ee8:	e9 a0 f8 ff ff       	jmp    8010578d <alltraps>

80105eed <vector79>:
80105eed:	6a 00                	push   $0x0
80105eef:	6a 4f                	push   $0x4f
80105ef1:	e9 97 f8 ff ff       	jmp    8010578d <alltraps>

80105ef6 <vector80>:
80105ef6:	6a 00                	push   $0x0
80105ef8:	6a 50                	push   $0x50
80105efa:	e9 8e f8 ff ff       	jmp    8010578d <alltraps>

80105eff <vector81>:
80105eff:	6a 00                	push   $0x0
80105f01:	6a 51                	push   $0x51
80105f03:	e9 85 f8 ff ff       	jmp    8010578d <alltraps>

80105f08 <vector82>:
80105f08:	6a 00                	push   $0x0
80105f0a:	6a 52                	push   $0x52
80105f0c:	e9 7c f8 ff ff       	jmp    8010578d <alltraps>

80105f11 <vector83>:
80105f11:	6a 00                	push   $0x0
80105f13:	6a 53                	push   $0x53
80105f15:	e9 73 f8 ff ff       	jmp    8010578d <alltraps>

80105f1a <vector84>:
80105f1a:	6a 00                	push   $0x0
80105f1c:	6a 54                	push   $0x54
80105f1e:	e9 6a f8 ff ff       	jmp    8010578d <alltraps>

80105f23 <vector85>:
80105f23:	6a 00                	push   $0x0
80105f25:	6a 55                	push   $0x55
80105f27:	e9 61 f8 ff ff       	jmp    8010578d <alltraps>

80105f2c <vector86>:
80105f2c:	6a 00                	push   $0x0
80105f2e:	6a 56                	push   $0x56
80105f30:	e9 58 f8 ff ff       	jmp    8010578d <alltraps>

80105f35 <vector87>:
80105f35:	6a 00                	push   $0x0
80105f37:	6a 57                	push   $0x57
80105f39:	e9 4f f8 ff ff       	jmp    8010578d <alltraps>

80105f3e <vector88>:
80105f3e:	6a 00                	push   $0x0
80105f40:	6a 58                	push   $0x58
80105f42:	e9 46 f8 ff ff       	jmp    8010578d <alltraps>

80105f47 <vector89>:
80105f47:	6a 00                	push   $0x0
80105f49:	6a 59                	push   $0x59
80105f4b:	e9 3d f8 ff ff       	jmp    8010578d <alltraps>

80105f50 <vector90>:
80105f50:	6a 00                	push   $0x0
80105f52:	6a 5a                	push   $0x5a
80105f54:	e9 34 f8 ff ff       	jmp    8010578d <alltraps>

80105f59 <vector91>:
80105f59:	6a 00                	push   $0x0
80105f5b:	6a 5b                	push   $0x5b
80105f5d:	e9 2b f8 ff ff       	jmp    8010578d <alltraps>

80105f62 <vector92>:
80105f62:	6a 00                	push   $0x0
80105f64:	6a 5c                	push   $0x5c
80105f66:	e9 22 f8 ff ff       	jmp    8010578d <alltraps>

80105f6b <vector93>:
80105f6b:	6a 00                	push   $0x0
80105f6d:	6a 5d                	push   $0x5d
80105f6f:	e9 19 f8 ff ff       	jmp    8010578d <alltraps>

80105f74 <vector94>:
80105f74:	6a 00                	push   $0x0
80105f76:	6a 5e                	push   $0x5e
80105f78:	e9 10 f8 ff ff       	jmp    8010578d <alltraps>

80105f7d <vector95>:
80105f7d:	6a 00                	push   $0x0
80105f7f:	6a 5f                	push   $0x5f
80105f81:	e9 07 f8 ff ff       	jmp    8010578d <alltraps>

80105f86 <vector96>:
80105f86:	6a 00                	push   $0x0
80105f88:	6a 60                	push   $0x60
80105f8a:	e9 fe f7 ff ff       	jmp    8010578d <alltraps>

80105f8f <vector97>:
80105f8f:	6a 00                	push   $0x0
80105f91:	6a 61                	push   $0x61
80105f93:	e9 f5 f7 ff ff       	jmp    8010578d <alltraps>

80105f98 <vector98>:
80105f98:	6a 00                	push   $0x0
80105f9a:	6a 62                	push   $0x62
80105f9c:	e9 ec f7 ff ff       	jmp    8010578d <alltraps>

80105fa1 <vector99>:
80105fa1:	6a 00                	push   $0x0
80105fa3:	6a 63                	push   $0x63
80105fa5:	e9 e3 f7 ff ff       	jmp    8010578d <alltraps>

80105faa <vector100>:
80105faa:	6a 00                	push   $0x0
80105fac:	6a 64                	push   $0x64
80105fae:	e9 da f7 ff ff       	jmp    8010578d <alltraps>

80105fb3 <vector101>:
80105fb3:	6a 00                	push   $0x0
80105fb5:	6a 65                	push   $0x65
80105fb7:	e9 d1 f7 ff ff       	jmp    8010578d <alltraps>

80105fbc <vector102>:
80105fbc:	6a 00                	push   $0x0
80105fbe:	6a 66                	push   $0x66
80105fc0:	e9 c8 f7 ff ff       	jmp    8010578d <alltraps>

80105fc5 <vector103>:
80105fc5:	6a 00                	push   $0x0
80105fc7:	6a 67                	push   $0x67
80105fc9:	e9 bf f7 ff ff       	jmp    8010578d <alltraps>

80105fce <vector104>:
80105fce:	6a 00                	push   $0x0
80105fd0:	6a 68                	push   $0x68
80105fd2:	e9 b6 f7 ff ff       	jmp    8010578d <alltraps>

80105fd7 <vector105>:
80105fd7:	6a 00                	push   $0x0
80105fd9:	6a 69                	push   $0x69
80105fdb:	e9 ad f7 ff ff       	jmp    8010578d <alltraps>

80105fe0 <vector106>:
80105fe0:	6a 00                	push   $0x0
80105fe2:	6a 6a                	push   $0x6a
80105fe4:	e9 a4 f7 ff ff       	jmp    8010578d <alltraps>

80105fe9 <vector107>:
80105fe9:	6a 00                	push   $0x0
80105feb:	6a 6b                	push   $0x6b
80105fed:	e9 9b f7 ff ff       	jmp    8010578d <alltraps>

80105ff2 <vector108>:
80105ff2:	6a 00                	push   $0x0
80105ff4:	6a 6c                	push   $0x6c
80105ff6:	e9 92 f7 ff ff       	jmp    8010578d <alltraps>

80105ffb <vector109>:
80105ffb:	6a 00                	push   $0x0
80105ffd:	6a 6d                	push   $0x6d
80105fff:	e9 89 f7 ff ff       	jmp    8010578d <alltraps>

80106004 <vector110>:
80106004:	6a 00                	push   $0x0
80106006:	6a 6e                	push   $0x6e
80106008:	e9 80 f7 ff ff       	jmp    8010578d <alltraps>

8010600d <vector111>:
8010600d:	6a 00                	push   $0x0
8010600f:	6a 6f                	push   $0x6f
80106011:	e9 77 f7 ff ff       	jmp    8010578d <alltraps>

80106016 <vector112>:
80106016:	6a 00                	push   $0x0
80106018:	6a 70                	push   $0x70
8010601a:	e9 6e f7 ff ff       	jmp    8010578d <alltraps>

8010601f <vector113>:
8010601f:	6a 00                	push   $0x0
80106021:	6a 71                	push   $0x71
80106023:	e9 65 f7 ff ff       	jmp    8010578d <alltraps>

80106028 <vector114>:
80106028:	6a 00                	push   $0x0
8010602a:	6a 72                	push   $0x72
8010602c:	e9 5c f7 ff ff       	jmp    8010578d <alltraps>

80106031 <vector115>:
80106031:	6a 00                	push   $0x0
80106033:	6a 73                	push   $0x73
80106035:	e9 53 f7 ff ff       	jmp    8010578d <alltraps>

8010603a <vector116>:
8010603a:	6a 00                	push   $0x0
8010603c:	6a 74                	push   $0x74
8010603e:	e9 4a f7 ff ff       	jmp    8010578d <alltraps>

80106043 <vector117>:
80106043:	6a 00                	push   $0x0
80106045:	6a 75                	push   $0x75
80106047:	e9 41 f7 ff ff       	jmp    8010578d <alltraps>

8010604c <vector118>:
8010604c:	6a 00                	push   $0x0
8010604e:	6a 76                	push   $0x76
80106050:	e9 38 f7 ff ff       	jmp    8010578d <alltraps>

80106055 <vector119>:
80106055:	6a 00                	push   $0x0
80106057:	6a 77                	push   $0x77
80106059:	e9 2f f7 ff ff       	jmp    8010578d <alltraps>

8010605e <vector120>:
8010605e:	6a 00                	push   $0x0
80106060:	6a 78                	push   $0x78
80106062:	e9 26 f7 ff ff       	jmp    8010578d <alltraps>

80106067 <vector121>:
80106067:	6a 00                	push   $0x0
80106069:	6a 79                	push   $0x79
8010606b:	e9 1d f7 ff ff       	jmp    8010578d <alltraps>

80106070 <vector122>:
80106070:	6a 00                	push   $0x0
80106072:	6a 7a                	push   $0x7a
80106074:	e9 14 f7 ff ff       	jmp    8010578d <alltraps>

80106079 <vector123>:
80106079:	6a 00                	push   $0x0
8010607b:	6a 7b                	push   $0x7b
8010607d:	e9 0b f7 ff ff       	jmp    8010578d <alltraps>

80106082 <vector124>:
80106082:	6a 00                	push   $0x0
80106084:	6a 7c                	push   $0x7c
80106086:	e9 02 f7 ff ff       	jmp    8010578d <alltraps>

8010608b <vector125>:
8010608b:	6a 00                	push   $0x0
8010608d:	6a 7d                	push   $0x7d
8010608f:	e9 f9 f6 ff ff       	jmp    8010578d <alltraps>

80106094 <vector126>:
80106094:	6a 00                	push   $0x0
80106096:	6a 7e                	push   $0x7e
80106098:	e9 f0 f6 ff ff       	jmp    8010578d <alltraps>

8010609d <vector127>:
8010609d:	6a 00                	push   $0x0
8010609f:	6a 7f                	push   $0x7f
801060a1:	e9 e7 f6 ff ff       	jmp    8010578d <alltraps>

801060a6 <vector128>:
801060a6:	6a 00                	push   $0x0
801060a8:	68 80 00 00 00       	push   $0x80
801060ad:	e9 db f6 ff ff       	jmp    8010578d <alltraps>

801060b2 <vector129>:
801060b2:	6a 00                	push   $0x0
801060b4:	68 81 00 00 00       	push   $0x81
801060b9:	e9 cf f6 ff ff       	jmp    8010578d <alltraps>

801060be <vector130>:
801060be:	6a 00                	push   $0x0
801060c0:	68 82 00 00 00       	push   $0x82
801060c5:	e9 c3 f6 ff ff       	jmp    8010578d <alltraps>

801060ca <vector131>:
801060ca:	6a 00                	push   $0x0
801060cc:	68 83 00 00 00       	push   $0x83
801060d1:	e9 b7 f6 ff ff       	jmp    8010578d <alltraps>

801060d6 <vector132>:
801060d6:	6a 00                	push   $0x0
801060d8:	68 84 00 00 00       	push   $0x84
801060dd:	e9 ab f6 ff ff       	jmp    8010578d <alltraps>

801060e2 <vector133>:
801060e2:	6a 00                	push   $0x0
801060e4:	68 85 00 00 00       	push   $0x85
801060e9:	e9 9f f6 ff ff       	jmp    8010578d <alltraps>

801060ee <vector134>:
801060ee:	6a 00                	push   $0x0
801060f0:	68 86 00 00 00       	push   $0x86
801060f5:	e9 93 f6 ff ff       	jmp    8010578d <alltraps>

801060fa <vector135>:
801060fa:	6a 00                	push   $0x0
801060fc:	68 87 00 00 00       	push   $0x87
80106101:	e9 87 f6 ff ff       	jmp    8010578d <alltraps>

80106106 <vector136>:
80106106:	6a 00                	push   $0x0
80106108:	68 88 00 00 00       	push   $0x88
8010610d:	e9 7b f6 ff ff       	jmp    8010578d <alltraps>

80106112 <vector137>:
80106112:	6a 00                	push   $0x0
80106114:	68 89 00 00 00       	push   $0x89
80106119:	e9 6f f6 ff ff       	jmp    8010578d <alltraps>

8010611e <vector138>:
8010611e:	6a 00                	push   $0x0
80106120:	68 8a 00 00 00       	push   $0x8a
80106125:	e9 63 f6 ff ff       	jmp    8010578d <alltraps>

8010612a <vector139>:
8010612a:	6a 00                	push   $0x0
8010612c:	68 8b 00 00 00       	push   $0x8b
80106131:	e9 57 f6 ff ff       	jmp    8010578d <alltraps>

80106136 <vector140>:
80106136:	6a 00                	push   $0x0
80106138:	68 8c 00 00 00       	push   $0x8c
8010613d:	e9 4b f6 ff ff       	jmp    8010578d <alltraps>

80106142 <vector141>:
80106142:	6a 00                	push   $0x0
80106144:	68 8d 00 00 00       	push   $0x8d
80106149:	e9 3f f6 ff ff       	jmp    8010578d <alltraps>

8010614e <vector142>:
8010614e:	6a 00                	push   $0x0
80106150:	68 8e 00 00 00       	push   $0x8e
80106155:	e9 33 f6 ff ff       	jmp    8010578d <alltraps>

8010615a <vector143>:
8010615a:	6a 00                	push   $0x0
8010615c:	68 8f 00 00 00       	push   $0x8f
80106161:	e9 27 f6 ff ff       	jmp    8010578d <alltraps>

80106166 <vector144>:
80106166:	6a 00                	push   $0x0
80106168:	68 90 00 00 00       	push   $0x90
8010616d:	e9 1b f6 ff ff       	jmp    8010578d <alltraps>

80106172 <vector145>:
80106172:	6a 00                	push   $0x0
80106174:	68 91 00 00 00       	push   $0x91
80106179:	e9 0f f6 ff ff       	jmp    8010578d <alltraps>

8010617e <vector146>:
8010617e:	6a 00                	push   $0x0
80106180:	68 92 00 00 00       	push   $0x92
80106185:	e9 03 f6 ff ff       	jmp    8010578d <alltraps>

8010618a <vector147>:
8010618a:	6a 00                	push   $0x0
8010618c:	68 93 00 00 00       	push   $0x93
80106191:	e9 f7 f5 ff ff       	jmp    8010578d <alltraps>

80106196 <vector148>:
80106196:	6a 00                	push   $0x0
80106198:	68 94 00 00 00       	push   $0x94
8010619d:	e9 eb f5 ff ff       	jmp    8010578d <alltraps>

801061a2 <vector149>:
801061a2:	6a 00                	push   $0x0
801061a4:	68 95 00 00 00       	push   $0x95
801061a9:	e9 df f5 ff ff       	jmp    8010578d <alltraps>

801061ae <vector150>:
801061ae:	6a 00                	push   $0x0
801061b0:	68 96 00 00 00       	push   $0x96
801061b5:	e9 d3 f5 ff ff       	jmp    8010578d <alltraps>

801061ba <vector151>:
801061ba:	6a 00                	push   $0x0
801061bc:	68 97 00 00 00       	push   $0x97
801061c1:	e9 c7 f5 ff ff       	jmp    8010578d <alltraps>

801061c6 <vector152>:
801061c6:	6a 00                	push   $0x0
801061c8:	68 98 00 00 00       	push   $0x98
801061cd:	e9 bb f5 ff ff       	jmp    8010578d <alltraps>

801061d2 <vector153>:
801061d2:	6a 00                	push   $0x0
801061d4:	68 99 00 00 00       	push   $0x99
801061d9:	e9 af f5 ff ff       	jmp    8010578d <alltraps>

801061de <vector154>:
801061de:	6a 00                	push   $0x0
801061e0:	68 9a 00 00 00       	push   $0x9a
801061e5:	e9 a3 f5 ff ff       	jmp    8010578d <alltraps>

801061ea <vector155>:
801061ea:	6a 00                	push   $0x0
801061ec:	68 9b 00 00 00       	push   $0x9b
801061f1:	e9 97 f5 ff ff       	jmp    8010578d <alltraps>

801061f6 <vector156>:
801061f6:	6a 00                	push   $0x0
801061f8:	68 9c 00 00 00       	push   $0x9c
801061fd:	e9 8b f5 ff ff       	jmp    8010578d <alltraps>

80106202 <vector157>:
80106202:	6a 00                	push   $0x0
80106204:	68 9d 00 00 00       	push   $0x9d
80106209:	e9 7f f5 ff ff       	jmp    8010578d <alltraps>

8010620e <vector158>:
8010620e:	6a 00                	push   $0x0
80106210:	68 9e 00 00 00       	push   $0x9e
80106215:	e9 73 f5 ff ff       	jmp    8010578d <alltraps>

8010621a <vector159>:
8010621a:	6a 00                	push   $0x0
8010621c:	68 9f 00 00 00       	push   $0x9f
80106221:	e9 67 f5 ff ff       	jmp    8010578d <alltraps>

80106226 <vector160>:
80106226:	6a 00                	push   $0x0
80106228:	68 a0 00 00 00       	push   $0xa0
8010622d:	e9 5b f5 ff ff       	jmp    8010578d <alltraps>

80106232 <vector161>:
80106232:	6a 00                	push   $0x0
80106234:	68 a1 00 00 00       	push   $0xa1
80106239:	e9 4f f5 ff ff       	jmp    8010578d <alltraps>

8010623e <vector162>:
8010623e:	6a 00                	push   $0x0
80106240:	68 a2 00 00 00       	push   $0xa2
80106245:	e9 43 f5 ff ff       	jmp    8010578d <alltraps>

8010624a <vector163>:
8010624a:	6a 00                	push   $0x0
8010624c:	68 a3 00 00 00       	push   $0xa3
80106251:	e9 37 f5 ff ff       	jmp    8010578d <alltraps>

80106256 <vector164>:
80106256:	6a 00                	push   $0x0
80106258:	68 a4 00 00 00       	push   $0xa4
8010625d:	e9 2b f5 ff ff       	jmp    8010578d <alltraps>

80106262 <vector165>:
80106262:	6a 00                	push   $0x0
80106264:	68 a5 00 00 00       	push   $0xa5
80106269:	e9 1f f5 ff ff       	jmp    8010578d <alltraps>

8010626e <vector166>:
8010626e:	6a 00                	push   $0x0
80106270:	68 a6 00 00 00       	push   $0xa6
80106275:	e9 13 f5 ff ff       	jmp    8010578d <alltraps>

8010627a <vector167>:
8010627a:	6a 00                	push   $0x0
8010627c:	68 a7 00 00 00       	push   $0xa7
80106281:	e9 07 f5 ff ff       	jmp    8010578d <alltraps>

80106286 <vector168>:
80106286:	6a 00                	push   $0x0
80106288:	68 a8 00 00 00       	push   $0xa8
8010628d:	e9 fb f4 ff ff       	jmp    8010578d <alltraps>

80106292 <vector169>:
80106292:	6a 00                	push   $0x0
80106294:	68 a9 00 00 00       	push   $0xa9
80106299:	e9 ef f4 ff ff       	jmp    8010578d <alltraps>

8010629e <vector170>:
8010629e:	6a 00                	push   $0x0
801062a0:	68 aa 00 00 00       	push   $0xaa
801062a5:	e9 e3 f4 ff ff       	jmp    8010578d <alltraps>

801062aa <vector171>:
801062aa:	6a 00                	push   $0x0
801062ac:	68 ab 00 00 00       	push   $0xab
801062b1:	e9 d7 f4 ff ff       	jmp    8010578d <alltraps>

801062b6 <vector172>:
801062b6:	6a 00                	push   $0x0
801062b8:	68 ac 00 00 00       	push   $0xac
801062bd:	e9 cb f4 ff ff       	jmp    8010578d <alltraps>

801062c2 <vector173>:
801062c2:	6a 00                	push   $0x0
801062c4:	68 ad 00 00 00       	push   $0xad
801062c9:	e9 bf f4 ff ff       	jmp    8010578d <alltraps>

801062ce <vector174>:
801062ce:	6a 00                	push   $0x0
801062d0:	68 ae 00 00 00       	push   $0xae
801062d5:	e9 b3 f4 ff ff       	jmp    8010578d <alltraps>

801062da <vector175>:
801062da:	6a 00                	push   $0x0
801062dc:	68 af 00 00 00       	push   $0xaf
801062e1:	e9 a7 f4 ff ff       	jmp    8010578d <alltraps>

801062e6 <vector176>:
801062e6:	6a 00                	push   $0x0
801062e8:	68 b0 00 00 00       	push   $0xb0
801062ed:	e9 9b f4 ff ff       	jmp    8010578d <alltraps>

801062f2 <vector177>:
801062f2:	6a 00                	push   $0x0
801062f4:	68 b1 00 00 00       	push   $0xb1
801062f9:	e9 8f f4 ff ff       	jmp    8010578d <alltraps>

801062fe <vector178>:
801062fe:	6a 00                	push   $0x0
80106300:	68 b2 00 00 00       	push   $0xb2
80106305:	e9 83 f4 ff ff       	jmp    8010578d <alltraps>

8010630a <vector179>:
8010630a:	6a 00                	push   $0x0
8010630c:	68 b3 00 00 00       	push   $0xb3
80106311:	e9 77 f4 ff ff       	jmp    8010578d <alltraps>

80106316 <vector180>:
80106316:	6a 00                	push   $0x0
80106318:	68 b4 00 00 00       	push   $0xb4
8010631d:	e9 6b f4 ff ff       	jmp    8010578d <alltraps>

80106322 <vector181>:
80106322:	6a 00                	push   $0x0
80106324:	68 b5 00 00 00       	push   $0xb5
80106329:	e9 5f f4 ff ff       	jmp    8010578d <alltraps>

8010632e <vector182>:
8010632e:	6a 00                	push   $0x0
80106330:	68 b6 00 00 00       	push   $0xb6
80106335:	e9 53 f4 ff ff       	jmp    8010578d <alltraps>

8010633a <vector183>:
8010633a:	6a 00                	push   $0x0
8010633c:	68 b7 00 00 00       	push   $0xb7
80106341:	e9 47 f4 ff ff       	jmp    8010578d <alltraps>

80106346 <vector184>:
80106346:	6a 00                	push   $0x0
80106348:	68 b8 00 00 00       	push   $0xb8
8010634d:	e9 3b f4 ff ff       	jmp    8010578d <alltraps>

80106352 <vector185>:
80106352:	6a 00                	push   $0x0
80106354:	68 b9 00 00 00       	push   $0xb9
80106359:	e9 2f f4 ff ff       	jmp    8010578d <alltraps>

8010635e <vector186>:
8010635e:	6a 00                	push   $0x0
80106360:	68 ba 00 00 00       	push   $0xba
80106365:	e9 23 f4 ff ff       	jmp    8010578d <alltraps>

8010636a <vector187>:
8010636a:	6a 00                	push   $0x0
8010636c:	68 bb 00 00 00       	push   $0xbb
80106371:	e9 17 f4 ff ff       	jmp    8010578d <alltraps>

80106376 <vector188>:
80106376:	6a 00                	push   $0x0
80106378:	68 bc 00 00 00       	push   $0xbc
8010637d:	e9 0b f4 ff ff       	jmp    8010578d <alltraps>

80106382 <vector189>:
80106382:	6a 00                	push   $0x0
80106384:	68 bd 00 00 00       	push   $0xbd
80106389:	e9 ff f3 ff ff       	jmp    8010578d <alltraps>

8010638e <vector190>:
8010638e:	6a 00                	push   $0x0
80106390:	68 be 00 00 00       	push   $0xbe
80106395:	e9 f3 f3 ff ff       	jmp    8010578d <alltraps>

8010639a <vector191>:
8010639a:	6a 00                	push   $0x0
8010639c:	68 bf 00 00 00       	push   $0xbf
801063a1:	e9 e7 f3 ff ff       	jmp    8010578d <alltraps>

801063a6 <vector192>:
801063a6:	6a 00                	push   $0x0
801063a8:	68 c0 00 00 00       	push   $0xc0
801063ad:	e9 db f3 ff ff       	jmp    8010578d <alltraps>

801063b2 <vector193>:
801063b2:	6a 00                	push   $0x0
801063b4:	68 c1 00 00 00       	push   $0xc1
801063b9:	e9 cf f3 ff ff       	jmp    8010578d <alltraps>

801063be <vector194>:
801063be:	6a 00                	push   $0x0
801063c0:	68 c2 00 00 00       	push   $0xc2
801063c5:	e9 c3 f3 ff ff       	jmp    8010578d <alltraps>

801063ca <vector195>:
801063ca:	6a 00                	push   $0x0
801063cc:	68 c3 00 00 00       	push   $0xc3
801063d1:	e9 b7 f3 ff ff       	jmp    8010578d <alltraps>

801063d6 <vector196>:
801063d6:	6a 00                	push   $0x0
801063d8:	68 c4 00 00 00       	push   $0xc4
801063dd:	e9 ab f3 ff ff       	jmp    8010578d <alltraps>

801063e2 <vector197>:
801063e2:	6a 00                	push   $0x0
801063e4:	68 c5 00 00 00       	push   $0xc5
801063e9:	e9 9f f3 ff ff       	jmp    8010578d <alltraps>

801063ee <vector198>:
801063ee:	6a 00                	push   $0x0
801063f0:	68 c6 00 00 00       	push   $0xc6
801063f5:	e9 93 f3 ff ff       	jmp    8010578d <alltraps>

801063fa <vector199>:
801063fa:	6a 00                	push   $0x0
801063fc:	68 c7 00 00 00       	push   $0xc7
80106401:	e9 87 f3 ff ff       	jmp    8010578d <alltraps>

80106406 <vector200>:
80106406:	6a 00                	push   $0x0
80106408:	68 c8 00 00 00       	push   $0xc8
8010640d:	e9 7b f3 ff ff       	jmp    8010578d <alltraps>

80106412 <vector201>:
80106412:	6a 00                	push   $0x0
80106414:	68 c9 00 00 00       	push   $0xc9
80106419:	e9 6f f3 ff ff       	jmp    8010578d <alltraps>

8010641e <vector202>:
8010641e:	6a 00                	push   $0x0
80106420:	68 ca 00 00 00       	push   $0xca
80106425:	e9 63 f3 ff ff       	jmp    8010578d <alltraps>

8010642a <vector203>:
8010642a:	6a 00                	push   $0x0
8010642c:	68 cb 00 00 00       	push   $0xcb
80106431:	e9 57 f3 ff ff       	jmp    8010578d <alltraps>

80106436 <vector204>:
80106436:	6a 00                	push   $0x0
80106438:	68 cc 00 00 00       	push   $0xcc
8010643d:	e9 4b f3 ff ff       	jmp    8010578d <alltraps>

80106442 <vector205>:
80106442:	6a 00                	push   $0x0
80106444:	68 cd 00 00 00       	push   $0xcd
80106449:	e9 3f f3 ff ff       	jmp    8010578d <alltraps>

8010644e <vector206>:
8010644e:	6a 00                	push   $0x0
80106450:	68 ce 00 00 00       	push   $0xce
80106455:	e9 33 f3 ff ff       	jmp    8010578d <alltraps>

8010645a <vector207>:
8010645a:	6a 00                	push   $0x0
8010645c:	68 cf 00 00 00       	push   $0xcf
80106461:	e9 27 f3 ff ff       	jmp    8010578d <alltraps>

80106466 <vector208>:
80106466:	6a 00                	push   $0x0
80106468:	68 d0 00 00 00       	push   $0xd0
8010646d:	e9 1b f3 ff ff       	jmp    8010578d <alltraps>

80106472 <vector209>:
80106472:	6a 00                	push   $0x0
80106474:	68 d1 00 00 00       	push   $0xd1
80106479:	e9 0f f3 ff ff       	jmp    8010578d <alltraps>

8010647e <vector210>:
8010647e:	6a 00                	push   $0x0
80106480:	68 d2 00 00 00       	push   $0xd2
80106485:	e9 03 f3 ff ff       	jmp    8010578d <alltraps>

8010648a <vector211>:
8010648a:	6a 00                	push   $0x0
8010648c:	68 d3 00 00 00       	push   $0xd3
80106491:	e9 f7 f2 ff ff       	jmp    8010578d <alltraps>

80106496 <vector212>:
80106496:	6a 00                	push   $0x0
80106498:	68 d4 00 00 00       	push   $0xd4
8010649d:	e9 eb f2 ff ff       	jmp    8010578d <alltraps>

801064a2 <vector213>:
801064a2:	6a 00                	push   $0x0
801064a4:	68 d5 00 00 00       	push   $0xd5
801064a9:	e9 df f2 ff ff       	jmp    8010578d <alltraps>

801064ae <vector214>:
801064ae:	6a 00                	push   $0x0
801064b0:	68 d6 00 00 00       	push   $0xd6
801064b5:	e9 d3 f2 ff ff       	jmp    8010578d <alltraps>

801064ba <vector215>:
801064ba:	6a 00                	push   $0x0
801064bc:	68 d7 00 00 00       	push   $0xd7
801064c1:	e9 c7 f2 ff ff       	jmp    8010578d <alltraps>

801064c6 <vector216>:
801064c6:	6a 00                	push   $0x0
801064c8:	68 d8 00 00 00       	push   $0xd8
801064cd:	e9 bb f2 ff ff       	jmp    8010578d <alltraps>

801064d2 <vector217>:
801064d2:	6a 00                	push   $0x0
801064d4:	68 d9 00 00 00       	push   $0xd9
801064d9:	e9 af f2 ff ff       	jmp    8010578d <alltraps>

801064de <vector218>:
801064de:	6a 00                	push   $0x0
801064e0:	68 da 00 00 00       	push   $0xda
801064e5:	e9 a3 f2 ff ff       	jmp    8010578d <alltraps>

801064ea <vector219>:
801064ea:	6a 00                	push   $0x0
801064ec:	68 db 00 00 00       	push   $0xdb
801064f1:	e9 97 f2 ff ff       	jmp    8010578d <alltraps>

801064f6 <vector220>:
801064f6:	6a 00                	push   $0x0
801064f8:	68 dc 00 00 00       	push   $0xdc
801064fd:	e9 8b f2 ff ff       	jmp    8010578d <alltraps>

80106502 <vector221>:
80106502:	6a 00                	push   $0x0
80106504:	68 dd 00 00 00       	push   $0xdd
80106509:	e9 7f f2 ff ff       	jmp    8010578d <alltraps>

8010650e <vector222>:
8010650e:	6a 00                	push   $0x0
80106510:	68 de 00 00 00       	push   $0xde
80106515:	e9 73 f2 ff ff       	jmp    8010578d <alltraps>

8010651a <vector223>:
8010651a:	6a 00                	push   $0x0
8010651c:	68 df 00 00 00       	push   $0xdf
80106521:	e9 67 f2 ff ff       	jmp    8010578d <alltraps>

80106526 <vector224>:
80106526:	6a 00                	push   $0x0
80106528:	68 e0 00 00 00       	push   $0xe0
8010652d:	e9 5b f2 ff ff       	jmp    8010578d <alltraps>

80106532 <vector225>:
80106532:	6a 00                	push   $0x0
80106534:	68 e1 00 00 00       	push   $0xe1
80106539:	e9 4f f2 ff ff       	jmp    8010578d <alltraps>

8010653e <vector226>:
8010653e:	6a 00                	push   $0x0
80106540:	68 e2 00 00 00       	push   $0xe2
80106545:	e9 43 f2 ff ff       	jmp    8010578d <alltraps>

8010654a <vector227>:
8010654a:	6a 00                	push   $0x0
8010654c:	68 e3 00 00 00       	push   $0xe3
80106551:	e9 37 f2 ff ff       	jmp    8010578d <alltraps>

80106556 <vector228>:
80106556:	6a 00                	push   $0x0
80106558:	68 e4 00 00 00       	push   $0xe4
8010655d:	e9 2b f2 ff ff       	jmp    8010578d <alltraps>

80106562 <vector229>:
80106562:	6a 00                	push   $0x0
80106564:	68 e5 00 00 00       	push   $0xe5
80106569:	e9 1f f2 ff ff       	jmp    8010578d <alltraps>

8010656e <vector230>:
8010656e:	6a 00                	push   $0x0
80106570:	68 e6 00 00 00       	push   $0xe6
80106575:	e9 13 f2 ff ff       	jmp    8010578d <alltraps>

8010657a <vector231>:
8010657a:	6a 00                	push   $0x0
8010657c:	68 e7 00 00 00       	push   $0xe7
80106581:	e9 07 f2 ff ff       	jmp    8010578d <alltraps>

80106586 <vector232>:
80106586:	6a 00                	push   $0x0
80106588:	68 e8 00 00 00       	push   $0xe8
8010658d:	e9 fb f1 ff ff       	jmp    8010578d <alltraps>

80106592 <vector233>:
80106592:	6a 00                	push   $0x0
80106594:	68 e9 00 00 00       	push   $0xe9
80106599:	e9 ef f1 ff ff       	jmp    8010578d <alltraps>

8010659e <vector234>:
8010659e:	6a 00                	push   $0x0
801065a0:	68 ea 00 00 00       	push   $0xea
801065a5:	e9 e3 f1 ff ff       	jmp    8010578d <alltraps>

801065aa <vector235>:
801065aa:	6a 00                	push   $0x0
801065ac:	68 eb 00 00 00       	push   $0xeb
801065b1:	e9 d7 f1 ff ff       	jmp    8010578d <alltraps>

801065b6 <vector236>:
801065b6:	6a 00                	push   $0x0
801065b8:	68 ec 00 00 00       	push   $0xec
801065bd:	e9 cb f1 ff ff       	jmp    8010578d <alltraps>

801065c2 <vector237>:
801065c2:	6a 00                	push   $0x0
801065c4:	68 ed 00 00 00       	push   $0xed
801065c9:	e9 bf f1 ff ff       	jmp    8010578d <alltraps>

801065ce <vector238>:
801065ce:	6a 00                	push   $0x0
801065d0:	68 ee 00 00 00       	push   $0xee
801065d5:	e9 b3 f1 ff ff       	jmp    8010578d <alltraps>

801065da <vector239>:
801065da:	6a 00                	push   $0x0
801065dc:	68 ef 00 00 00       	push   $0xef
801065e1:	e9 a7 f1 ff ff       	jmp    8010578d <alltraps>

801065e6 <vector240>:
801065e6:	6a 00                	push   $0x0
801065e8:	68 f0 00 00 00       	push   $0xf0
801065ed:	e9 9b f1 ff ff       	jmp    8010578d <alltraps>

801065f2 <vector241>:
801065f2:	6a 00                	push   $0x0
801065f4:	68 f1 00 00 00       	push   $0xf1
801065f9:	e9 8f f1 ff ff       	jmp    8010578d <alltraps>

801065fe <vector242>:
801065fe:	6a 00                	push   $0x0
80106600:	68 f2 00 00 00       	push   $0xf2
80106605:	e9 83 f1 ff ff       	jmp    8010578d <alltraps>

8010660a <vector243>:
8010660a:	6a 00                	push   $0x0
8010660c:	68 f3 00 00 00       	push   $0xf3
80106611:	e9 77 f1 ff ff       	jmp    8010578d <alltraps>

80106616 <vector244>:
80106616:	6a 00                	push   $0x0
80106618:	68 f4 00 00 00       	push   $0xf4
8010661d:	e9 6b f1 ff ff       	jmp    8010578d <alltraps>

80106622 <vector245>:
80106622:	6a 00                	push   $0x0
80106624:	68 f5 00 00 00       	push   $0xf5
80106629:	e9 5f f1 ff ff       	jmp    8010578d <alltraps>

8010662e <vector246>:
8010662e:	6a 00                	push   $0x0
80106630:	68 f6 00 00 00       	push   $0xf6
80106635:	e9 53 f1 ff ff       	jmp    8010578d <alltraps>

8010663a <vector247>:
8010663a:	6a 00                	push   $0x0
8010663c:	68 f7 00 00 00       	push   $0xf7
80106641:	e9 47 f1 ff ff       	jmp    8010578d <alltraps>

80106646 <vector248>:
80106646:	6a 00                	push   $0x0
80106648:	68 f8 00 00 00       	push   $0xf8
8010664d:	e9 3b f1 ff ff       	jmp    8010578d <alltraps>

80106652 <vector249>:
80106652:	6a 00                	push   $0x0
80106654:	68 f9 00 00 00       	push   $0xf9
80106659:	e9 2f f1 ff ff       	jmp    8010578d <alltraps>

8010665e <vector250>:
8010665e:	6a 00                	push   $0x0
80106660:	68 fa 00 00 00       	push   $0xfa
80106665:	e9 23 f1 ff ff       	jmp    8010578d <alltraps>

8010666a <vector251>:
8010666a:	6a 00                	push   $0x0
8010666c:	68 fb 00 00 00       	push   $0xfb
80106671:	e9 17 f1 ff ff       	jmp    8010578d <alltraps>

80106676 <vector252>:
80106676:	6a 00                	push   $0x0
80106678:	68 fc 00 00 00       	push   $0xfc
8010667d:	e9 0b f1 ff ff       	jmp    8010578d <alltraps>

80106682 <vector253>:
80106682:	6a 00                	push   $0x0
80106684:	68 fd 00 00 00       	push   $0xfd
80106689:	e9 ff f0 ff ff       	jmp    8010578d <alltraps>

8010668e <vector254>:
8010668e:	6a 00                	push   $0x0
80106690:	68 fe 00 00 00       	push   $0xfe
80106695:	e9 f3 f0 ff ff       	jmp    8010578d <alltraps>

8010669a <vector255>:
8010669a:	6a 00                	push   $0x0
8010669c:	68 ff 00 00 00       	push   $0xff
801066a1:	e9 e7 f0 ff ff       	jmp    8010578d <alltraps>
801066a6:	66 90                	xchg   %ax,%ax
801066a8:	66 90                	xchg   %ax,%ax
801066aa:	66 90                	xchg   %ax,%ax
801066ac:	66 90                	xchg   %ax,%ax
801066ae:	66 90                	xchg   %ax,%ax

801066b0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801066b0:	55                   	push   %ebp
801066b1:	89 e5                	mov    %esp,%ebp
801066b3:	57                   	push   %edi
801066b4:	56                   	push   %esi
801066b5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801066b7:	c1 ea 16             	shr    $0x16,%edx
{
801066ba:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
801066bb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
801066be:	83 ec 1c             	sub    $0x1c,%esp
  if(*pde & PTE_P){
801066c1:	8b 1f                	mov    (%edi),%ebx
801066c3:	f6 c3 01             	test   $0x1,%bl
801066c6:	74 28                	je     801066f0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801066c8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801066ce:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801066d4:	c1 ee 0a             	shr    $0xa,%esi
}
801066d7:	83 c4 1c             	add    $0x1c,%esp
  return &pgtab[PTX(va)];
801066da:	89 f2                	mov    %esi,%edx
801066dc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801066e2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801066e5:	5b                   	pop    %ebx
801066e6:	5e                   	pop    %esi
801066e7:	5f                   	pop    %edi
801066e8:	5d                   	pop    %ebp
801066e9:	c3                   	ret    
801066ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801066f0:	85 c9                	test   %ecx,%ecx
801066f2:	74 34                	je     80106728 <walkpgdir+0x78>
801066f4:	e8 a7 bd ff ff       	call   801024a0 <kalloc>
801066f9:	85 c0                	test   %eax,%eax
801066fb:	89 c3                	mov    %eax,%ebx
801066fd:	74 29                	je     80106728 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
801066ff:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106706:	00 
80106707:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010670e:	00 
8010670f:	89 04 24             	mov    %eax,(%esp)
80106712:	e8 29 de ff ff       	call   80104540 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106717:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010671d:	83 c8 07             	or     $0x7,%eax
80106720:	89 07                	mov    %eax,(%edi)
80106722:	eb b0                	jmp    801066d4 <walkpgdir+0x24>
80106724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80106728:	83 c4 1c             	add    $0x1c,%esp
      return 0;
8010672b:	31 c0                	xor    %eax,%eax
}
8010672d:	5b                   	pop    %ebx
8010672e:	5e                   	pop    %esi
8010672f:	5f                   	pop    %edi
80106730:	5d                   	pop    %ebp
80106731:	c3                   	ret    
80106732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106740 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	57                   	push   %edi
80106744:	56                   	push   %esi
80106745:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106746:	89 d3                	mov    %edx,%ebx
{
80106748:	83 ec 1c             	sub    $0x1c,%esp
8010674b:	8b 7d 08             	mov    0x8(%ebp),%edi
  a = (char*)PGROUNDDOWN((uint)va);
8010674e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106754:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106757:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
8010675b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010675e:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106762:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
80106769:	29 df                	sub    %ebx,%edi
8010676b:	eb 18                	jmp    80106785 <mappages+0x45>
8010676d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*pte & PTE_P)
80106770:	f6 00 01             	testb  $0x1,(%eax)
80106773:	75 3d                	jne    801067b2 <mappages+0x72>
    *pte = pa | perm | PTE_P;
80106775:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
80106778:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010677b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010677d:	74 29                	je     801067a8 <mappages+0x68>
      break;
    a += PGSIZE;
8010677f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106785:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106788:	b9 01 00 00 00       	mov    $0x1,%ecx
8010678d:	89 da                	mov    %ebx,%edx
8010678f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106792:	e8 19 ff ff ff       	call   801066b0 <walkpgdir>
80106797:	85 c0                	test   %eax,%eax
80106799:	75 d5                	jne    80106770 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010679b:	83 c4 1c             	add    $0x1c,%esp
      return -1;
8010679e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067a3:	5b                   	pop    %ebx
801067a4:	5e                   	pop    %esi
801067a5:	5f                   	pop    %edi
801067a6:	5d                   	pop    %ebp
801067a7:	c3                   	ret    
801067a8:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801067ab:	31 c0                	xor    %eax,%eax
}
801067ad:	5b                   	pop    %ebx
801067ae:	5e                   	pop    %esi
801067af:	5f                   	pop    %edi
801067b0:	5d                   	pop    %ebp
801067b1:	c3                   	ret    
      panic("remap");
801067b2:	c7 04 24 f4 78 10 80 	movl   $0x801078f4,(%esp)
801067b9:	e8 a2 9b ff ff       	call   80100360 <panic>
801067be:	66 90                	xchg   %ax,%ax

801067c0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801067c0:	55                   	push   %ebp
801067c1:	89 e5                	mov    %esp,%ebp
801067c3:	57                   	push   %edi
801067c4:	89 c7                	mov    %eax,%edi
801067c6:	56                   	push   %esi
801067c7:	89 d6                	mov    %edx,%esi
801067c9:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801067ca:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801067d0:	83 ec 1c             	sub    $0x1c,%esp
  a = PGROUNDUP(newsz);
801067d3:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801067d9:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801067db:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801067de:	72 3b                	jb     8010681b <deallocuvm.part.0+0x5b>
801067e0:	eb 5e                	jmp    80106840 <deallocuvm.part.0+0x80>
801067e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801067e8:	8b 10                	mov    (%eax),%edx
801067ea:	f6 c2 01             	test   $0x1,%dl
801067ed:	74 22                	je     80106811 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801067ef:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801067f5:	74 54                	je     8010684b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
801067f7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801067fd:	89 14 24             	mov    %edx,(%esp)
80106800:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106803:	e8 e8 ba ff ff       	call   801022f0 <kfree>
      *pte = 0;
80106808:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010680b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106811:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106817:	39 f3                	cmp    %esi,%ebx
80106819:	73 25                	jae    80106840 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010681b:	31 c9                	xor    %ecx,%ecx
8010681d:	89 da                	mov    %ebx,%edx
8010681f:	89 f8                	mov    %edi,%eax
80106821:	e8 8a fe ff ff       	call   801066b0 <walkpgdir>
    if(!pte)
80106826:	85 c0                	test   %eax,%eax
80106828:	75 be                	jne    801067e8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010682a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106830:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106836:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010683c:	39 f3                	cmp    %esi,%ebx
8010683e:	72 db                	jb     8010681b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80106840:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106843:	83 c4 1c             	add    $0x1c,%esp
80106846:	5b                   	pop    %ebx
80106847:	5e                   	pop    %esi
80106848:	5f                   	pop    %edi
80106849:	5d                   	pop    %ebp
8010684a:	c3                   	ret    
        panic("kfree");
8010684b:	c7 04 24 26 72 10 80 	movl   $0x80107226,(%esp)
80106852:	e8 09 9b ff ff       	call   80100360 <panic>
80106857:	89 f6                	mov    %esi,%esi
80106859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106860 <seginit>:
{
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106866:	e8 65 ce ff ff       	call   801036d0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010686b:	31 c9                	xor    %ecx,%ecx
8010686d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c = &cpus[cpuid()];
80106872:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106878:	05 80 27 11 80       	add    $0x80112780,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010687d:	66 89 50 78          	mov    %dx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106881:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  lgdt(c->gdt, sizeof(c->gdt));
80106886:	83 c0 70             	add    $0x70,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106889:	66 89 48 0a          	mov    %cx,0xa(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010688d:	31 c9                	xor    %ecx,%ecx
8010688f:	66 89 50 10          	mov    %dx,0x10(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106893:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106898:	66 89 48 12          	mov    %cx,0x12(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010689c:	31 c9                	xor    %ecx,%ecx
8010689e:	66 89 50 18          	mov    %dx,0x18(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801068a2:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801068a7:	66 89 48 1a          	mov    %cx,0x1a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801068ab:	31 c9                	xor    %ecx,%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801068ad:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
801068b1:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801068b5:	c6 40 15 92          	movb   $0x92,0x15(%eax)
801068b9:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801068bd:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
801068c1:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801068c5:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
801068c9:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
801068cd:	66 89 50 20          	mov    %dx,0x20(%eax)
  pd[0] = size-1;
801068d1:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801068d6:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
801068da:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801068de:	c6 40 14 00          	movb   $0x0,0x14(%eax)
801068e2:	c6 40 17 00          	movb   $0x0,0x17(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801068e6:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
801068ea:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801068ee:	66 89 48 22          	mov    %cx,0x22(%eax)
801068f2:	c6 40 24 00          	movb   $0x0,0x24(%eax)
801068f6:	c6 40 27 00          	movb   $0x0,0x27(%eax)
801068fa:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801068fe:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106902:	c1 e8 10             	shr    $0x10,%eax
80106905:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106909:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010690c:	0f 01 10             	lgdtl  (%eax)
}
8010690f:	c9                   	leave  
80106910:	c3                   	ret    
80106911:	eb 0d                	jmp    80106920 <switchkvm>
80106913:	90                   	nop
80106914:	90                   	nop
80106915:	90                   	nop
80106916:	90                   	nop
80106917:	90                   	nop
80106918:	90                   	nop
80106919:	90                   	nop
8010691a:	90                   	nop
8010691b:	90                   	nop
8010691c:	90                   	nop
8010691d:	90                   	nop
8010691e:	90                   	nop
8010691f:	90                   	nop

80106920 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106920:	a1 a4 58 11 80       	mov    0x801158a4,%eax
{
80106925:	55                   	push   %ebp
80106926:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106928:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010692d:	0f 22 d8             	mov    %eax,%cr3
}
80106930:	5d                   	pop    %ebp
80106931:	c3                   	ret    
80106932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106940 <switchuvm>:
{
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
80106943:	57                   	push   %edi
80106944:	56                   	push   %esi
80106945:	53                   	push   %ebx
80106946:	83 ec 1c             	sub    $0x1c,%esp
80106949:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010694c:	85 f6                	test   %esi,%esi
8010694e:	0f 84 cd 00 00 00    	je     80106a21 <switchuvm+0xe1>
  if(p->kstack == 0)
80106954:	8b 46 08             	mov    0x8(%esi),%eax
80106957:	85 c0                	test   %eax,%eax
80106959:	0f 84 da 00 00 00    	je     80106a39 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010695f:	8b 7e 04             	mov    0x4(%esi),%edi
80106962:	85 ff                	test   %edi,%edi
80106964:	0f 84 c3 00 00 00    	je     80106a2d <switchuvm+0xed>
  pushcli();
8010696a:	e8 21 da ff ff       	call   80104390 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010696f:	e8 dc cc ff ff       	call   80103650 <mycpu>
80106974:	89 c3                	mov    %eax,%ebx
80106976:	e8 d5 cc ff ff       	call   80103650 <mycpu>
8010697b:	89 c7                	mov    %eax,%edi
8010697d:	e8 ce cc ff ff       	call   80103650 <mycpu>
80106982:	83 c7 08             	add    $0x8,%edi
80106985:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106988:	e8 c3 cc ff ff       	call   80103650 <mycpu>
8010698d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106990:	ba 67 00 00 00       	mov    $0x67,%edx
80106995:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
8010699c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801069a3:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
801069aa:	83 c1 08             	add    $0x8,%ecx
801069ad:	c1 e9 10             	shr    $0x10,%ecx
801069b0:	83 c0 08             	add    $0x8,%eax
801069b3:	c1 e8 18             	shr    $0x18,%eax
801069b6:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801069bc:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
801069c3:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801069c9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801069ce:	e8 7d cc ff ff       	call   80103650 <mycpu>
801069d3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801069da:	e8 71 cc ff ff       	call   80103650 <mycpu>
801069df:	b9 10 00 00 00       	mov    $0x10,%ecx
801069e4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801069e8:	e8 63 cc ff ff       	call   80103650 <mycpu>
801069ed:	8b 56 08             	mov    0x8(%esi),%edx
801069f0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801069f6:	89 48 0c             	mov    %ecx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801069f9:	e8 52 cc ff ff       	call   80103650 <mycpu>
801069fe:	66 89 58 6e          	mov    %bx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106a02:	b8 28 00 00 00       	mov    $0x28,%eax
80106a07:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106a0a:	8b 46 04             	mov    0x4(%esi),%eax
80106a0d:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a12:	0f 22 d8             	mov    %eax,%cr3
}
80106a15:	83 c4 1c             	add    $0x1c,%esp
80106a18:	5b                   	pop    %ebx
80106a19:	5e                   	pop    %esi
80106a1a:	5f                   	pop    %edi
80106a1b:	5d                   	pop    %ebp
  popcli();
80106a1c:	e9 af d9 ff ff       	jmp    801043d0 <popcli>
    panic("switchuvm: no process");
80106a21:	c7 04 24 fa 78 10 80 	movl   $0x801078fa,(%esp)
80106a28:	e8 33 99 ff ff       	call   80100360 <panic>
    panic("switchuvm: no pgdir");
80106a2d:	c7 04 24 25 79 10 80 	movl   $0x80107925,(%esp)
80106a34:	e8 27 99 ff ff       	call   80100360 <panic>
    panic("switchuvm: no kstack");
80106a39:	c7 04 24 10 79 10 80 	movl   $0x80107910,(%esp)
80106a40:	e8 1b 99 ff ff       	call   80100360 <panic>
80106a45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a50 <inituvm>:
{
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	57                   	push   %edi
80106a54:	56                   	push   %esi
80106a55:	53                   	push   %ebx
80106a56:	83 ec 1c             	sub    $0x1c,%esp
80106a59:	8b 75 10             	mov    0x10(%ebp),%esi
80106a5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a5f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106a62:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106a68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106a6b:	77 54                	ja     80106ac1 <inituvm+0x71>
  mem = kalloc();
80106a6d:	e8 2e ba ff ff       	call   801024a0 <kalloc>
  memset(mem, 0, PGSIZE);
80106a72:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106a79:	00 
80106a7a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a81:	00 
  mem = kalloc();
80106a82:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106a84:	89 04 24             	mov    %eax,(%esp)
80106a87:	e8 b4 da ff ff       	call   80104540 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106a8c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a92:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106a97:	89 04 24             	mov    %eax,(%esp)
80106a9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a9d:	31 d2                	xor    %edx,%edx
80106a9f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106aa6:	00 
80106aa7:	e8 94 fc ff ff       	call   80106740 <mappages>
  memmove(mem, init, sz);
80106aac:	89 75 10             	mov    %esi,0x10(%ebp)
80106aaf:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106ab2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106ab5:	83 c4 1c             	add    $0x1c,%esp
80106ab8:	5b                   	pop    %ebx
80106ab9:	5e                   	pop    %esi
80106aba:	5f                   	pop    %edi
80106abb:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106abc:	e9 1f db ff ff       	jmp    801045e0 <memmove>
    panic("inituvm: more than a page");
80106ac1:	c7 04 24 39 79 10 80 	movl   $0x80107939,(%esp)
80106ac8:	e8 93 98 ff ff       	call   80100360 <panic>
80106acd:	8d 76 00             	lea    0x0(%esi),%esi

80106ad0 <loaduvm>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80106ad9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106ae0:	0f 85 98 00 00 00    	jne    80106b7e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80106ae6:	8b 75 18             	mov    0x18(%ebp),%esi
80106ae9:	31 db                	xor    %ebx,%ebx
80106aeb:	85 f6                	test   %esi,%esi
80106aed:	75 1a                	jne    80106b09 <loaduvm+0x39>
80106aef:	eb 77                	jmp    80106b68 <loaduvm+0x98>
80106af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106af8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106afe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b04:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b07:	76 5f                	jbe    80106b68 <loaduvm+0x98>
80106b09:	8b 55 0c             	mov    0xc(%ebp),%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106b0c:	31 c9                	xor    %ecx,%ecx
80106b0e:	8b 45 08             	mov    0x8(%ebp),%eax
80106b11:	01 da                	add    %ebx,%edx
80106b13:	e8 98 fb ff ff       	call   801066b0 <walkpgdir>
80106b18:	85 c0                	test   %eax,%eax
80106b1a:	74 56                	je     80106b72 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
80106b1c:	8b 00                	mov    (%eax),%eax
      n = PGSIZE;
80106b1e:	bf 00 10 00 00       	mov    $0x1000,%edi
80106b23:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80106b26:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      n = PGSIZE;
80106b2b:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106b31:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b34:	05 00 00 00 80       	add    $0x80000000,%eax
80106b39:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b3d:	8b 45 10             	mov    0x10(%ebp),%eax
80106b40:	01 d9                	add    %ebx,%ecx
80106b42:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106b46:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106b4a:	89 04 24             	mov    %eax,(%esp)
80106b4d:	e8 0e ae ff ff       	call   80101960 <readi>
80106b52:	39 f8                	cmp    %edi,%eax
80106b54:	74 a2                	je     80106af8 <loaduvm+0x28>
}
80106b56:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80106b59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b5e:	5b                   	pop    %ebx
80106b5f:	5e                   	pop    %esi
80106b60:	5f                   	pop    %edi
80106b61:	5d                   	pop    %ebp
80106b62:	c3                   	ret    
80106b63:	90                   	nop
80106b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106b68:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80106b6b:	31 c0                	xor    %eax,%eax
}
80106b6d:	5b                   	pop    %ebx
80106b6e:	5e                   	pop    %esi
80106b6f:	5f                   	pop    %edi
80106b70:	5d                   	pop    %ebp
80106b71:	c3                   	ret    
      panic("loaduvm: address should exist");
80106b72:	c7 04 24 53 79 10 80 	movl   $0x80107953,(%esp)
80106b79:	e8 e2 97 ff ff       	call   80100360 <panic>
    panic("loaduvm: addr must be page aligned");
80106b7e:	c7 04 24 f4 79 10 80 	movl   $0x801079f4,(%esp)
80106b85:	e8 d6 97 ff ff       	call   80100360 <panic>
80106b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b90 <allocuvm>:
{
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	57                   	push   %edi
80106b94:	56                   	push   %esi
80106b95:	53                   	push   %ebx
80106b96:	83 ec 1c             	sub    $0x1c,%esp
80106b99:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
80106b9c:	85 ff                	test   %edi,%edi
80106b9e:	0f 88 7e 00 00 00    	js     80106c22 <allocuvm+0x92>
  if(newsz < oldsz)
80106ba4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106ba7:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106baa:	72 78                	jb     80106c24 <allocuvm+0x94>
  a = PGROUNDUP(oldsz);
80106bac:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106bb2:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106bb8:	39 df                	cmp    %ebx,%edi
80106bba:	77 4a                	ja     80106c06 <allocuvm+0x76>
80106bbc:	eb 72                	jmp    80106c30 <allocuvm+0xa0>
80106bbe:	66 90                	xchg   %ax,%ax
    memset(mem, 0, PGSIZE);
80106bc0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106bc7:	00 
80106bc8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106bcf:	00 
80106bd0:	89 04 24             	mov    %eax,(%esp)
80106bd3:	e8 68 d9 ff ff       	call   80104540 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106bd8:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106bde:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106be3:	89 04 24             	mov    %eax,(%esp)
80106be6:	8b 45 08             	mov    0x8(%ebp),%eax
80106be9:	89 da                	mov    %ebx,%edx
80106beb:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106bf2:	00 
80106bf3:	e8 48 fb ff ff       	call   80106740 <mappages>
80106bf8:	85 c0                	test   %eax,%eax
80106bfa:	78 44                	js     80106c40 <allocuvm+0xb0>
  for(; a < newsz; a += PGSIZE){
80106bfc:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c02:	39 df                	cmp    %ebx,%edi
80106c04:	76 2a                	jbe    80106c30 <allocuvm+0xa0>
    mem = kalloc();
80106c06:	e8 95 b8 ff ff       	call   801024a0 <kalloc>
    if(mem == 0){
80106c0b:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106c0d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106c0f:	75 af                	jne    80106bc0 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106c11:	c7 04 24 71 79 10 80 	movl   $0x80107971,(%esp)
80106c18:	e8 33 9a ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80106c1d:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c20:	77 48                	ja     80106c6a <allocuvm+0xda>
      return 0;
80106c22:	31 c0                	xor    %eax,%eax
}
80106c24:	83 c4 1c             	add    $0x1c,%esp
80106c27:	5b                   	pop    %ebx
80106c28:	5e                   	pop    %esi
80106c29:	5f                   	pop    %edi
80106c2a:	5d                   	pop    %ebp
80106c2b:	c3                   	ret    
80106c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c30:	83 c4 1c             	add    $0x1c,%esp
80106c33:	89 f8                	mov    %edi,%eax
80106c35:	5b                   	pop    %ebx
80106c36:	5e                   	pop    %esi
80106c37:	5f                   	pop    %edi
80106c38:	5d                   	pop    %ebp
80106c39:	c3                   	ret    
80106c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106c40:	c7 04 24 89 79 10 80 	movl   $0x80107989,(%esp)
80106c47:	e8 04 9a ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80106c4c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c4f:	76 0d                	jbe    80106c5e <allocuvm+0xce>
80106c51:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c54:	89 fa                	mov    %edi,%edx
80106c56:	8b 45 08             	mov    0x8(%ebp),%eax
80106c59:	e8 62 fb ff ff       	call   801067c0 <deallocuvm.part.0>
      kfree(mem);
80106c5e:	89 34 24             	mov    %esi,(%esp)
80106c61:	e8 8a b6 ff ff       	call   801022f0 <kfree>
      return 0;
80106c66:	31 c0                	xor    %eax,%eax
80106c68:	eb ba                	jmp    80106c24 <allocuvm+0x94>
80106c6a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c6d:	89 fa                	mov    %edi,%edx
80106c6f:	8b 45 08             	mov    0x8(%ebp),%eax
80106c72:	e8 49 fb ff ff       	call   801067c0 <deallocuvm.part.0>
      return 0;
80106c77:	31 c0                	xor    %eax,%eax
80106c79:	eb a9                	jmp    80106c24 <allocuvm+0x94>
80106c7b:	90                   	nop
80106c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c80 <deallocuvm>:
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c86:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106c89:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106c8c:	39 d1                	cmp    %edx,%ecx
80106c8e:	73 08                	jae    80106c98 <deallocuvm+0x18>
}
80106c90:	5d                   	pop    %ebp
80106c91:	e9 2a fb ff ff       	jmp    801067c0 <deallocuvm.part.0>
80106c96:	66 90                	xchg   %ax,%ax
80106c98:	89 d0                	mov    %edx,%eax
80106c9a:	5d                   	pop    %ebp
80106c9b:	c3                   	ret    
80106c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ca0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	56                   	push   %esi
80106ca4:	53                   	push   %ebx
80106ca5:	83 ec 10             	sub    $0x10,%esp
80106ca8:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106cab:	85 f6                	test   %esi,%esi
80106cad:	74 59                	je     80106d08 <freevm+0x68>
80106caf:	31 c9                	xor    %ecx,%ecx
80106cb1:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106cb6:	89 f0                	mov    %esi,%eax
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cb8:	31 db                	xor    %ebx,%ebx
80106cba:	e8 01 fb ff ff       	call   801067c0 <deallocuvm.part.0>
80106cbf:	eb 12                	jmp    80106cd3 <freevm+0x33>
80106cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cc8:	83 c3 01             	add    $0x1,%ebx
80106ccb:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106cd1:	74 27                	je     80106cfa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106cd3:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
80106cd6:	f6 c2 01             	test   $0x1,%dl
80106cd9:	74 ed                	je     80106cc8 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106cdb:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(i = 0; i < NPDENTRIES; i++){
80106ce1:	83 c3 01             	add    $0x1,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ce4:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106cea:	89 14 24             	mov    %edx,(%esp)
80106ced:	e8 fe b5 ff ff       	call   801022f0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80106cf2:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106cf8:	75 d9                	jne    80106cd3 <freevm+0x33>
    }
  }
  kfree((char*)pgdir);
80106cfa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106cfd:	83 c4 10             	add    $0x10,%esp
80106d00:	5b                   	pop    %ebx
80106d01:	5e                   	pop    %esi
80106d02:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106d03:	e9 e8 b5 ff ff       	jmp    801022f0 <kfree>
    panic("freevm: no pgdir");
80106d08:	c7 04 24 a5 79 10 80 	movl   $0x801079a5,(%esp)
80106d0f:	e8 4c 96 ff ff       	call   80100360 <panic>
80106d14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d20 <setupkvm>:
{
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	56                   	push   %esi
80106d24:	53                   	push   %ebx
80106d25:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80106d28:	e8 73 b7 ff ff       	call   801024a0 <kalloc>
80106d2d:	85 c0                	test   %eax,%eax
80106d2f:	89 c6                	mov    %eax,%esi
80106d31:	74 6d                	je     80106da0 <setupkvm+0x80>
  memset(pgdir, 0, PGSIZE);
80106d33:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106d3a:	00 
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106d3b:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106d40:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106d47:	00 
80106d48:	89 04 24             	mov    %eax,(%esp)
80106d4b:	e8 f0 d7 ff ff       	call   80104540 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106d50:	8b 53 0c             	mov    0xc(%ebx),%edx
80106d53:	8b 43 04             	mov    0x4(%ebx),%eax
80106d56:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106d59:	89 54 24 04          	mov    %edx,0x4(%esp)
80106d5d:	8b 13                	mov    (%ebx),%edx
80106d5f:	89 04 24             	mov    %eax,(%esp)
80106d62:	29 c1                	sub    %eax,%ecx
80106d64:	89 f0                	mov    %esi,%eax
80106d66:	e8 d5 f9 ff ff       	call   80106740 <mappages>
80106d6b:	85 c0                	test   %eax,%eax
80106d6d:	78 19                	js     80106d88 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106d6f:	83 c3 10             	add    $0x10,%ebx
80106d72:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106d78:	72 d6                	jb     80106d50 <setupkvm+0x30>
80106d7a:	89 f0                	mov    %esi,%eax
}
80106d7c:	83 c4 10             	add    $0x10,%esp
80106d7f:	5b                   	pop    %ebx
80106d80:	5e                   	pop    %esi
80106d81:	5d                   	pop    %ebp
80106d82:	c3                   	ret    
80106d83:	90                   	nop
80106d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106d88:	89 34 24             	mov    %esi,(%esp)
80106d8b:	e8 10 ff ff ff       	call   80106ca0 <freevm>
}
80106d90:	83 c4 10             	add    $0x10,%esp
      return 0;
80106d93:	31 c0                	xor    %eax,%eax
}
80106d95:	5b                   	pop    %ebx
80106d96:	5e                   	pop    %esi
80106d97:	5d                   	pop    %ebp
80106d98:	c3                   	ret    
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106da0:	31 c0                	xor    %eax,%eax
80106da2:	eb d8                	jmp    80106d7c <setupkvm+0x5c>
80106da4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106daa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106db0 <kvmalloc>:
{
80106db0:	55                   	push   %ebp
80106db1:	89 e5                	mov    %esp,%ebp
80106db3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106db6:	e8 65 ff ff ff       	call   80106d20 <setupkvm>
80106dbb:	a3 a4 58 11 80       	mov    %eax,0x801158a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106dc0:	05 00 00 00 80       	add    $0x80000000,%eax
80106dc5:	0f 22 d8             	mov    %eax,%cr3
}
80106dc8:	c9                   	leave  
80106dc9:	c3                   	ret    
80106dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106dd0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106dd0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106dd1:	31 c9                	xor    %ecx,%ecx
{
80106dd3:	89 e5                	mov    %esp,%ebp
80106dd5:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106dd8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ddb:	8b 45 08             	mov    0x8(%ebp),%eax
80106dde:	e8 cd f8 ff ff       	call   801066b0 <walkpgdir>
  if(pte == 0)
80106de3:	85 c0                	test   %eax,%eax
80106de5:	74 05                	je     80106dec <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106de7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106dea:	c9                   	leave  
80106deb:	c3                   	ret    
    panic("clearpteu");
80106dec:	c7 04 24 b6 79 10 80 	movl   $0x801079b6,(%esp)
80106df3:	e8 68 95 ff ff       	call   80100360 <panic>
80106df8:	90                   	nop
80106df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e00 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	57                   	push   %edi
80106e04:	56                   	push   %esi
80106e05:	53                   	push   %ebx
80106e06:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106e09:	e8 12 ff ff ff       	call   80106d20 <setupkvm>
80106e0e:	85 c0                	test   %eax,%eax
80106e10:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106e13:	0f 84 b9 00 00 00    	je     80106ed2 <copyuvm+0xd2>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106e19:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e1c:	85 c0                	test   %eax,%eax
80106e1e:	0f 84 94 00 00 00    	je     80106eb8 <copyuvm+0xb8>
80106e24:	31 ff                	xor    %edi,%edi
80106e26:	eb 48                	jmp    80106e70 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106e28:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106e2e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106e35:	00 
80106e36:	89 74 24 04          	mov    %esi,0x4(%esp)
80106e3a:	89 04 24             	mov    %eax,(%esp)
80106e3d:	e8 9e d7 ff ff       	call   801045e0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106e42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e45:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e4a:	89 fa                	mov    %edi,%edx
80106e4c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e50:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e56:	89 04 24             	mov    %eax,(%esp)
80106e59:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e5c:	e8 df f8 ff ff       	call   80106740 <mappages>
80106e61:	85 c0                	test   %eax,%eax
80106e63:	78 63                	js     80106ec8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106e65:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106e6b:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106e6e:	76 48                	jbe    80106eb8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106e70:	8b 45 08             	mov    0x8(%ebp),%eax
80106e73:	31 c9                	xor    %ecx,%ecx
80106e75:	89 fa                	mov    %edi,%edx
80106e77:	e8 34 f8 ff ff       	call   801066b0 <walkpgdir>
80106e7c:	85 c0                	test   %eax,%eax
80106e7e:	74 62                	je     80106ee2 <copyuvm+0xe2>
    if(!(*pte & PTE_P))
80106e80:	8b 00                	mov    (%eax),%eax
80106e82:	a8 01                	test   $0x1,%al
80106e84:	74 50                	je     80106ed6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106e86:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80106e88:	25 ff 0f 00 00       	and    $0xfff,%eax
80106e8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80106e90:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    if((mem = kalloc()) == 0)
80106e96:	e8 05 b6 ff ff       	call   801024a0 <kalloc>
80106e9b:	85 c0                	test   %eax,%eax
80106e9d:	89 c3                	mov    %eax,%ebx
80106e9f:	75 87                	jne    80106e28 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80106ea1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ea4:	89 04 24             	mov    %eax,(%esp)
80106ea7:	e8 f4 fd ff ff       	call   80106ca0 <freevm>
  return 0;
80106eac:	31 c0                	xor    %eax,%eax
}
80106eae:	83 c4 2c             	add    $0x2c,%esp
80106eb1:	5b                   	pop    %ebx
80106eb2:	5e                   	pop    %esi
80106eb3:	5f                   	pop    %edi
80106eb4:	5d                   	pop    %ebp
80106eb5:	c3                   	ret    
80106eb6:	66 90                	xchg   %ax,%ax
80106eb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ebb:	83 c4 2c             	add    $0x2c,%esp
80106ebe:	5b                   	pop    %ebx
80106ebf:	5e                   	pop    %esi
80106ec0:	5f                   	pop    %edi
80106ec1:	5d                   	pop    %ebp
80106ec2:	c3                   	ret    
80106ec3:	90                   	nop
80106ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106ec8:	89 1c 24             	mov    %ebx,(%esp)
80106ecb:	e8 20 b4 ff ff       	call   801022f0 <kfree>
      goto bad;
80106ed0:	eb cf                	jmp    80106ea1 <copyuvm+0xa1>
    return 0;
80106ed2:	31 c0                	xor    %eax,%eax
80106ed4:	eb d8                	jmp    80106eae <copyuvm+0xae>
      panic("copyuvm: page not present");
80106ed6:	c7 04 24 da 79 10 80 	movl   $0x801079da,(%esp)
80106edd:	e8 7e 94 ff ff       	call   80100360 <panic>
      panic("copyuvm: pte should exist");
80106ee2:	c7 04 24 c0 79 10 80 	movl   $0x801079c0,(%esp)
80106ee9:	e8 72 94 ff ff       	call   80100360 <panic>
80106eee:	66 90                	xchg   %ax,%ax

80106ef0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106ef0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106ef1:	31 c9                	xor    %ecx,%ecx
{
80106ef3:	89 e5                	mov    %esp,%ebp
80106ef5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106ef8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106efb:	8b 45 08             	mov    0x8(%ebp),%eax
80106efe:	e8 ad f7 ff ff       	call   801066b0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106f03:	8b 00                	mov    (%eax),%eax
80106f05:	89 c2                	mov    %eax,%edx
80106f07:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
80106f0a:	83 fa 05             	cmp    $0x5,%edx
80106f0d:	75 11                	jne    80106f20 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106f0f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f14:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106f19:	c9                   	leave  
80106f1a:	c3                   	ret    
80106f1b:	90                   	nop
80106f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106f20:	31 c0                	xor    %eax,%eax
}
80106f22:	c9                   	leave  
80106f23:	c3                   	ret    
80106f24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f30 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	57                   	push   %edi
80106f34:	56                   	push   %esi
80106f35:	53                   	push   %ebx
80106f36:	83 ec 1c             	sub    $0x1c,%esp
80106f39:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106f3c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f3f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106f42:	85 db                	test   %ebx,%ebx
80106f44:	75 3a                	jne    80106f80 <copyout+0x50>
80106f46:	eb 68                	jmp    80106fb0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106f48:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f4b:	89 f2                	mov    %esi,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106f4d:	89 7c 24 04          	mov    %edi,0x4(%esp)
    n = PGSIZE - (va - va0);
80106f51:	29 ca                	sub    %ecx,%edx
80106f53:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106f59:	39 da                	cmp    %ebx,%edx
80106f5b:	0f 47 d3             	cmova  %ebx,%edx
    memmove(pa0 + (va - va0), buf, n);
80106f5e:	29 f1                	sub    %esi,%ecx
80106f60:	01 c8                	add    %ecx,%eax
80106f62:	89 54 24 08          	mov    %edx,0x8(%esp)
80106f66:	89 04 24             	mov    %eax,(%esp)
80106f69:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106f6c:	e8 6f d6 ff ff       	call   801045e0 <memmove>
    len -= n;
    buf += n;
80106f71:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80106f74:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    buf += n;
80106f7a:	01 d7                	add    %edx,%edi
  while(len > 0){
80106f7c:	29 d3                	sub    %edx,%ebx
80106f7e:	74 30                	je     80106fb0 <copyout+0x80>
    pa0 = uva2ka(pgdir, (char*)va0);
80106f80:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80106f83:	89 ce                	mov    %ecx,%esi
80106f85:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f8b:	89 74 24 04          	mov    %esi,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80106f8f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80106f92:	89 04 24             	mov    %eax,(%esp)
80106f95:	e8 56 ff ff ff       	call   80106ef0 <uva2ka>
    if(pa0 == 0)
80106f9a:	85 c0                	test   %eax,%eax
80106f9c:	75 aa                	jne    80106f48 <copyout+0x18>
  }
  return 0;
}
80106f9e:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80106fa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fa6:	5b                   	pop    %ebx
80106fa7:	5e                   	pop    %esi
80106fa8:	5f                   	pop    %edi
80106fa9:	5d                   	pop    %ebp
80106faa:	c3                   	ret    
80106fab:	90                   	nop
80106fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106fb0:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80106fb3:	31 c0                	xor    %eax,%eax
}
80106fb5:	5b                   	pop    %ebx
80106fb6:	5e                   	pop    %esi
80106fb7:	5f                   	pop    %edi
80106fb8:	5d                   	pop    %ebp
80106fb9:	c3                   	ret    
